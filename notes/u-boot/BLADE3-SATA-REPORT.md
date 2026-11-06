# Mixtile Blade 3: mSATA (sata2) boot in U-Boot

Date: 2026-10-24
Tree: mainline U-Boot v2026.10 + Armbian patches
Defconfig: `configs/mixtile-blade3-rk3588_defconfig`
Fix: `3ab5d6da529 ata: dwc_ahci: fall back to the phy in the sata-port subnode`

## Summary

The Blade 3 mini-PCIe socket can carry an mSATA disk. The socket's lane goes
through `combphy2_psu`, which is shared between `pcie2x1l1` and `sata2`, so
only one of them can be used at a time.

On RK3588, the built-in SATA controllers have never worked in mainline U-Boot.
`scsi scan` failed with:

```
=> scsi scan
scanning bus for devices...
can't get the phy from DT
```

This affects every RK3588 board and every on-board port (`sata0`, `sata1` and
`sata2`), not only the Blade 3. Only PCIe SATA cards (`AHCI_PCI`) work.

With the one-file driver fix below, the mSATA disk is found:

```
=> scsi scan
scanning bus for devices...
SATA link 0 timeout.
AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
flags: ncq stag pm led clo only pmp fbss pio slum part ccc apst
Target spinup took 0 ms.
AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
flags: ncq stag pm led clo only pmp fbss pio slum part ccc apst
  Device 0: (0:0) Vendor: ATA Prod.: mSATA SSD 512GB Rev: SN12
            Type: Hard Disk
            Capacity: 488386.3 MB = 476.9 GB (1000215217 x 512)
```

- **`SATA link 0 timeout`** comes from `sata0`, which has nothing attached.
  It is harmless.
- **Second AHCI block:** that is `sata2`, with the mSATA SSD.
- **Not yet tested:** a full boot from the mSATA disk.

## Root cause

`dwc_ahci_probe()` (`drivers/ata/dwc_ahci.c`) looks for the PHY only on the
controller node, by name:

```c
ret = generic_phy_get_by_name(dev, "sata-phy", &phy);
```

The RK3588 DT has always put the PHY in a `sata-port@0` subnode instead. This
dates back to the Linux commit that first added RK3588 SATA,
`34d6c15d8e862 arm64: dts: rockchip: add SATA support to rk3588`:

```dts
sata2: sata@fe230000 {
	compatible = "rockchip,rk3588-dwc-ahci", "snps,dwc-ahci";
	...
	sata-port@0 {
		reg = <0>;
		hba-port-cap = <HBA_PORT_FBSCP>;
		phys = <&combphy2_psu PHY_TYPE_SATA>;
		phy-names = "sata-phy";
		...
	};
};
```

Linux reads PHYs per port (`libahci_platform`), so it works there. U-Boot
syncs this DT, through the old in-tree copy and now `dts/upstream`, but has
never handled that layout:

- No RK3588 `*-u-boot.dtsi` adds `phys` to the controller node.
- `drivers/ata/` has no Rockchip-specific code.

RK3568 (`rk356x-base.dtsi`) puts `phys`/`phy-names` on the controller node,
which is why RK3568 boards work with `dwc_ahci`.

For comparison, the Rockchip vendor U-Boot's `rk3588s.dtsi` also puts
`phys = <&combphy2_psu PHY_TYPE_SATA>; phy-names = "sata-phy";` on the
controller node. That is why vendor U-Boot never hit this.

### Clocks: not an issue

`dwc_ahci` never enables its clocks. That is fine on RK3588:

- The RK3588 clock driver (`drivers/clk/rockchip/clk_rk3588.c`) has no
  `.enable`/`.disable` ops, so `clk_enable()` is a no-op anyway.
- The SATA gates are already open when U-Boot starts.
- Vendor U-Boot's `dwc_ahci.c` doesn't enable them either.
- The test above confirms it works without clock handling.

### GPIO4_A2 pull-up: not needed

Vendor U-Boot's `rk3588-blade3-sata.dts` sets GPIO4_A2 (`pcie2x1l1`'s
PERST#) as a GPIO with a pull-up. It was not needed for the disk above.

## Fix

The fix keeps the existing lookup and adds a fallback. If the controller has
no `"sata-phy"`, it uses the first PHY of the first enabled subnode. This
matches the DT layout without changing the TI/OMAP behaviour.

```diff
From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
From: Ricardo Pardini <ricardo@pardini.net>
Subject: [PATCH] ata: dwc_ahci: fall back to the phy in the sata-port subnode

- RK3588 DT puts phys in sata-port@N, not on the controller node with phy-names = "sata-phy"
- Without this, probe fails with "can't get the phy from DT" on all RK3588 on-board SATA
- Use the first enabled subnode's first phy if the controller has no "sata-phy"

Assisted-by: Claude Opus 5.5
Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
---
 drivers/ata/dwc_ahci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/ata/dwc_ahci.c b/drivers/ata/dwc_ahci.c
index 0431d370716..4422a88f70b 100644
--- a/drivers/ata/dwc_ahci.c
+++ b/drivers/ata/dwc_ahci.c
@@ -57,6 +57,18 @@ static int dwc_ahci_probe(struct udevice *dev)
 	struct phy phy;
 
 	ret = generic_phy_get_by_name(dev, "sata-phy", &phy);
+	if (ret) {
+		ofnode node;
+
+		/* e.g. RK3588: the phy is in the sata-port@N subnode */
+		dev_for_each_subnode(node, dev) {
+			if (!ofnode_is_enabled(node))
+				continue;
+			ret = generic_phy_get_by_index_nodev(node, 0, &phy);
+			if (!ret)
+				break;
+		}
+	}
 	if (ret) {
 		pr_err("can't get the phy from DT\n");
 		return ret;
```

- **Kconfig:** `DWC_AHCI` already `select PHY`, so
  `generic_phy_get_by_index_nodev()` is always available.
- **Multi-port controllers:** only the first port's PHY is brought up, as
  before. All RK3588 controllers have `ports-implemented = <0x1>`.

## Blade 3 specifics (Armbian)

| Piece | Where | What |
|-------|-------|------|
| Driver fix | `patch/u-boot/v2026.10/general-ata-dwc_ahci-fall-back-to-phy-in-sata-port-subnode.patch` | the patch above |
| U-Boot DT | `patch/u-boot/v2026.10/dt_uboot/rk3588-mixtile-blade3-u-boot.dtsi` | always `&sata2` okay, `&pcie2x1l1` disabled (U-Boot has no use for Wi-Fi/LTE cards; Linux re-initialises the combphy) |
| Boot order | `config/boards/mixtile-blade3.csc` | `mmc1 nvme scsi mmc0 pxe dhcp spi` (`scsi` was left out before) |
| Linux | existing `rockchip-rk3588-sata2.dtso` | `overlays=sata2` in `armbianEnv.txt` (rk3588 `OVERLAY_PREFIX`) |

Without this fix, adding `scsi` to the boot order would print the PHY error on
every Blade 3 boot, because `sata0` is enabled in the upstream Blade 3 DT.

## Prior art on lore.kernel.org

Nothing on the lists reports or fixes this. These are the related threads:

- **Original driver**, which required `phy-names = "sata-phy"` from the start:
  Jean-Jacques Hiblot, *drivers: block: dwc_ahci: Implement a driver for
  Synopsys DWC sata device* (2017).
  - v5: <https://lore.kernel.org/u-boot/1493027492-20978-7-git-send-email-jjhiblot@ti.com/>
- **Driver made buildable on Rockchip**, behind `#ifdef CONFIG_ARCH_OMAP2PLUS`.
  This was enough for RK3568's DT layout, not RK3588's:
  Jonas Karlman, *ata: dwc_ahci: Fix support for other platforms* (July 2023).
  - v1: <https://lore.kernel.org/u-boot/20230702204712.3872549-2-jonas@kwiboo.se/>
  - v3: <https://lore.kernel.org/u-boot/20230722140209.1897117-2-jonas@kwiboo.se/>
- **Rock 5B AHCI enablement**, which says it enables "the on-board SATA
  controller". No reply reports testing an on-board port, so only PCIe SATA
  cards were exercised. Jonas Karlman, *rockchip: rk3588-rock-5b: Enable
  support for PCIe SATA cards* (Oct 2023), merged as `191ece249a9`.
  - cover letter: <https://lore.kernel.org/u-boot/20231010222344.3436526-1-jonas@kwiboo.se/>
  - v1: <https://lore.kernel.org/u-boot/20231010222344.3436526-3-jonas@kwiboo.se/>
  - v2: <https://lore.kernel.org/u-boot/20231017170216.1627789-4-jonas@kwiboo.se/>
- **RK3588 DT sync with Linux**, which brought in the `sata-port@0` layout.
  `74273f1d9c8 arm: dts: rockchip: sync DT for RK3588 series with Linux`
  (2023). Kever Yang's review quotes the `sata-port@0` nodes with no comment
  on SATA:
  - <https://lore.kernel.org/u-boot/03534cab-6a86-ca34-093c-9807d83a8a82@rock-chips.com/>
- **Latest `dwc_ahci` change**, already in v2026.10 and unrelated to PHY
  lookup: Peng Fan, *ata: dwc_ahci: Use dev_read_addr_index()* (May 2026).
  - <https://lore.kernel.org/u-boot/20260526074616.2800003-2-peng.fan@nxp.com/>

These searches found nothing about RK3588 SATA in U-Boot, or about Blade 3
SATA/mSATA:

- u-boot: `"can't get the phy from DT"`, `"sata-port"`, `dwc_ahci AND rk3588`,
  and `scsi scan`/`ahci`/`sata` together with RK3588 board names since 2024.
- linux-rockchip: SATA + U-Boot + RK3588 since 2024.
- All lists: Blade 3 + SATA/mSATA.

## Upstreaming

- **Send to:** u-boot@lists.denx.de.
- **Suggested Cc:**
  - Jonas Karlman <jonas@kwiboo.se>, who did the Rockchip `dwc_ahci` and
    Rock 5B AHCI work.
  - Kever Yang <kever.yang@rock-chips.com>, Rockchip custodian.
- **Commit message:** rewrite it in prose for upstream, and add a `Fixes:`
  tag. A candidate is `74273f1d9c8`, the first RK3588 DT with SATA nodes.
- **Testing:** worth asking other RK3588 owners with an on-board SATA port to
  test, for example Rock 5B M.2 E-key or Orange Pi 5 Plus.

## Second bug: `ums 0 scsi 0` aborts (AHCI capacity off by one)

After the PHY fix, `scsi read` works at any size, but `ums 0 scsi 0` dies
after a moment:

```
=> ums 0 scsi 0
UMS: LUN 0, dev scsi 0, hwpart 0, sector 0x0, count 0x3b9e12b1
-timeout exit!
```

On the host (Linux):

```
sd 1:0:0:0: [sdc] 1000215217 512-byte logical blocks: (512 GB/477 GiB)
GPT:Primary header thinks Alt. header is not at the end of the disk.
GPT:1000215215 != 1000215216
...
sd 1:0:0:0: [sdc] tag#0 CDB: Read(10) 28 00 3b 9e 12 b0 00 00 01 00
I/O error, dev sdc, sector 1000215216 op 0x0:(READ)
```

### Root cause

The disk has 1000215216 sectors, the standard size for 512 GB. U-Boot reports
1000215217.

- SCSI READ CAPACITY (10/16) returns the **address of the last block**.
  `scsi_read_capacity()` (`drivers/scsi/scsi.c`) adds 1, which is correct.
  The `+1` came in with `5f7c06bdc3c scsi: fix disk capacity too small by one
  sector` (v2025.01):
  - v1: <https://lore.kernel.org/u-boot/20241014-fix-scsi-disksize-v1-1-0edb9959b580@devpi.de/>
  - v2: <https://lore.kernel.org/u-boot/20241026-fix-scsi-disksize-v2-1-bc6be9a6043d@devpi.de/>
  - applied: <https://lore.kernel.org/u-boot/173058991721.1044919.11636976888031217648.b4-ty@konsulko.com/>
- AHCI's emulation, `ata_scsiop_read_capacity10/16()` in `drivers/ata/ahci.c`,
  returns `ata_id_n_sectors()`, which is the **count**. So since
  `5f7c06bdc3c`, every AHCI disk is one sector too big. AHCI was not
  mentioned in that thread, and only that commit's sandbox test was updated.
  The sandbox emulator (`drivers/scsi/scsi_emul.c`) correctly returns
  `blocks - 1`.
- The host reads the extra sector because it looks for the backup GPT at the
  "end". The drive rejects the out-of-range LBA, but `ahci_device_data_io()`
  never checks PxIS.TFES/PxTFD.ERR. It waits the full `WAIT_MS_DATAIO`
  (10 s) and prints `timeout exit!`.
- `do_read()` in `f_mass_storage.c` returns `-EIO` on any read failure, and
  `do_usb_mass_storage()` exits on that.
- mmc and nvme report their sizes directly and don't use this path, which is
  why only SCSI failed.

### Fix

`9744031e7f6 ata: ahci: READ CAPACITY must return the last LBA, not the
sector count`. Both handlers now return `ata_id_n_sectors() - 1`, and the
READ CAPACITY(10) clamp is adjusted to match.

```diff
-	cap64 = ata_id_n_sectors(uc_priv->ataid[pccb->target]);
-	if (cap64 > 0x100000000ULL)
+	/* READ CAPACITY returns the address of the last block */
+	cap64 = ata_id_n_sectors(uc_priv->ataid[pccb->target]) - 1;
+	if (cap64 > 0xffffffffULL)
 		cap64 = 0xffffffff;
...
-	cap = ata_id_n_sectors(uc_priv->ataid[pccb->target]);
+	/* READ CAPACITY returns the address of the last block */
+	cap = ata_id_n_sectors(uc_priv->ataid[pccb->target]) - 1;
```

- **Fixes tag:** `Fixes: 5f7c06bdc3c ("scsi: fix disk capacity too small by
  one sector")`.
- **Armbian patch:**
  `patch/u-boot/v2026.10/general-ata-ahci-read-capacity-must-return-the-last-lba.patch`.
- **Expected after the fix:** `scsi info` shows `1000215216 x 512`, and the
  host's GPT warning goes away.
- **Separate, not fixed here:** AHCI doesn't detect drive errors, so any
  rejected command costs a 10 s timeout instead of failing at once.
- **Suggested Cc:** Julius Lehmann <lehmanju@devpi.de> and Neil Armstrong
  <neil.armstrong@linaro.org> (author and tester of `5f7c06bdc3c`).

### Tested (2026-10-24)

- **Board:** `scsi info` now shows `1000215216 x 512`, and
  `ums 0 scsi 0` reports `count 0x3b9e12b0` and keeps running.
- **Host (Linux, X13s):** sees `1000215216 512-byte logical blocks`. There is
  no GPT warning and no I/O errors or USB resets, and `sdc1` is found.

## Full boot from mSATA (2026-10-24)

Log: `sata-bootlog-full.txt`. U-Boot boots Armbian edge (7.3.0) from the mSATA
disk all the way to the login prompt:

- **U-Boot:** the SD card (mmc1), NVMe (`pcie@fe150000` link fails, nothing
  attached) and then `scsi` are tried, in that order. The disk is found as
  `1000215216 x 512`.
  - bootflow `ahci_scsi.id0lun0.bootdev.part_1` runs `/boot/boot.scr` from
    `scsi 0:1`.
  - Kernel and initrd load at about 61 MiB/s.
  - `rockchip-rk3588-sata2.dtbo` is applied from `overlays=sata2`.
- **Linux:**
  - `ata1` (sata0) has no link.
  - `ata2` (sata2): `SATA link up 1.5 Gbps (SStatus 113 SControl 300)`,
    `1000215216 sectors`, NCQ depth 32.
  - Root `sda1` is mounted by UUID.
  - No ATA errors, resets or speed downgrades anywhere in the log.

**Open question:** the link is only 1.5 Gb/s (Gen1) in Linux. U-Boot's
"6 Gbps" is the controller's capability, not the negotiated speed. Still to
find out:
- whether the drive supports Gen3: `smartctl -i`, look for "SATA Version is";
- what U-Boot negotiates: `md.l 0xfe230128 1` after `scsi scan`;
- whether the vendor kernel links faster.

## Third bug: sata2 stuck at 1.5 Gb/s (combphy `pipe_con1_for_sata` offset)

The drive is SATA 3.2, 6.0 Gb/s (`smartctl -i`), but U-Boot and Linux both
link at 1.5 Gb/s:
- U-Boot `md.l 0xfe230128 1` (PxSSTS) reads `0x113`.
- Linux: `SATA link up 1.5 Gbps (SStatus 113 SControl 300)`.
- `hdparm -t --direct` gives 124 MB/s, which is about the 1.5 Gb/s maximum.

### Root cause

`rk3588_combphy_grfcfgs.pipe_con1_for_sata` writes pipe-GRF (`php_grf`,
`0xfd5b0000`) **CON0** `0x0000` bits [2:0] = 2. It should be **CON1**
`0x0004`. Rockchip fixed this in their kernel in 2022:

- Vendor commit `2f5fe2c0bbd4f phy: rockchip: naneng-combophy: config sata2
  rate to 6G for rk3588` (Yifeng Zhao, 2022-09-03), which changes only
  `.pipe_con1_for_sata = { 0x0000, ...}` to `{ 0x0004, ...}`.

Mainline Linux (`a03c44277253`) and U-Boot (`c5b4a012bca8`) both still have
`0x0000`. U-Boot's RK3588 SATA path does write `pipe_con1_for_sata`, but to
the wrong register.

Mainline gets `sata1` to 6.0 Gbps without this. See Arthur Fabre's Rock 5 ITX
report, which is about a different regression (`fbcbffbac994` "fix phy
reset") and has no replies:
- <https://lore.kernel.org/linux-phy/DGKOC0Y8UWRH.3TVFOP2ND9W9J@arthurfabre.com/>

So the bits matter for sata2 at least, as the vendor commit title says.

### Proof, in U-Boot before the first `scsi scan`

```
=> md.l 0xfd5b0000 2
fd5b0000: 00000820 00000000
=> mw.l 0xfd5b0004 0x00070002
=> scsi scan
...
=> md.l 0xfe230128 1
fe230128: 00000133
```

`0x133` is 6.0 Gb/s. The vendor's other SATA tweak, `347d284ff8348` "adjust
ssc ppm parameter for sata" (3500 ppm, PHY register `0x24`), was **not**
needed.

### Fix, the same one line in both trees

```diff
 	.pipe_con0_for_sata	= { 0x0000, 11, 5, 0x00, 0x22 },
-	.pipe_con1_for_sata	= { 0x0000, 2, 0, 0x00, 0x2 },
+	.pipe_con1_for_sata	= { 0x0004, 2, 0, 0x00, 0x2 },
```

- **U-Boot:** `f7b90928255 phy: rockchip: naneng-combphy: fix rk3588
  pipe_con1_for_sata offset`, with `Fixes: c5b4a012bca8`.
  - Armbian:
    `patch/u-boot/v2026.10/general-phy-rockchip-naneng-combphy-fix-rk3588-pipe_con1_for_sata-offset.patch`
- **Linux** (rockchip64-7.3 worktree): `172469edead0a`, same subject, with
  `Fixes: a03c44277253`.
  - Armbian:
    `patch/kernel/archive/rockchip64-7.3/914-phy-rockchip-naneng-combphy-fix-rk3588-pipe_con1_for_sata-offset.patch`
- **Upstream (Linux):** send to linux-phy with Cc to Heiko Stuebner,
  Shawn Lin and Yifeng Zhao (author of the vendor fix). Reply to Arthur's
  thread too.
- **Still to test:** that U-Boot and Linux with these patches built in
  reach 6.0 Gbps on their own, and that sata0/sata1 boards don't regress.

### Tested with the fix built into U-Boot and the kernel (2026-10-24)

Log: `sata-bootlog-full-after-kernel-and-uboot-6gbps-fix.txt`

- **Linux:** `ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)` on the
  first try, with no speed limiting or errors.
- **smartctl:** `SATA Version is: SATA 3.2, 6.0 Gb/s (current: 6.0 Gb/s)`.
- **hdparm:** `hdparm -t --direct /dev/sda` gives **421.78 MB/s**, up from
  124.45 MB/s at 1.5 Gb/s.
- **U-Boot:** still boots from `scsi 0:1` and loads at about 61 MiB/s, the
  same as before.
  - U-Boot's AHCI driver issues one polled 64 KiB command at a time, so that
    rate isn't limited by the link.
  - This log doesn't include the U-Boot PxSSTS value. Run
    `md.l 0xfe230128 1` after `scsi scan` to confirm `0x133` in U-Boot as
    well.
