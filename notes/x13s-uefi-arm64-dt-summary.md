# ThinkPad X13s on uefi-arm64-dt: effort summary

## Outcome

Stopped by the user before completion. Nothing was committed or pushed.

- Goal: move `thinkpad-x13s` from the `sc8280xp` family (steev 7.0 kernel, grub with DTB, many customizations) to the generic `uefi-arm64-dt` family (mainline 7.3.y, UKI, Stubble selects the DTB).
- The system booted from USB on 7.3 only with debug flags and without `splash`.
- The clean image with `splash` hung in Plymouth, with no network.
- The latest image has a fix for one suspect (ttyS0 removed). It was verified statically, but it was not booted.
- Audio is broken. The cause is not known.

## Hardware and access

- Model 21BX001LGE, BIOS 1.63. Reach it with `ssh root@192.168.66.19` (USB Ethernet).
- USB test disk: `/dev/sda`, boot entry `Boot001C`.
- Remote one-shot boot: `efibootmgr -n 001C` and `grub-reboot`.
- Internal NVMe (Armbian trixie, 7.0.10-sc8280xp): never mounted or written. `BootOrder` not changed.

## Findings

### Boot

| Item | Result |
| --- | --- |
| Stubble | Works. CHID matches through Manufacturer + ProductSku. |
| `arm64.nopauth` | Required. Without it, boot hangs at "kfence: initialized". |
| `clk_ignore_unused` | Avoids a stall of 6 to 7 seconds. |
| `pd_ignore_unused`, `efi=noruntime` | Not necessary. |
| msm and ADSP removed from initramfs | Fails. Display is lost near the deferred-probe sync_state timeout, and the USB-C disk gets errors. |
| Early msm and ADSP, with firmware in initramfs | Works, with debug flags and without `splash`. |
| CDSP and SLPI firmware | Must be in initrd. If not, they stay offline (`request_firmware failed: -2`, no retry). |
| Userspace `pd-mapper`, `qrtr-tools` | Not necessary. |

Firmware needed in initramfs:

- `qcom/a660_sqe.fw`, `qcom/a660_gmu.bin`, `qcom/a690_gmu.bin`
- `qcom/sc8280xp/LENOVO/21BX/`: `qcadsp8280.mbn`, `qccdsp8280.mbn`, `qcslpi8280.mbn`, `qcdxkmsuc8280.mbn`

### Device status

- Work or load: battery, Type-C, GPU firmware, Wi-Fi driver, BT firmware, camera and Iris modules.
- Not tested: DP, Wi-Fi association, GPU 3D, camera use, suspend.
- Not resolved: BT MAC.

### Audio

Symptoms: `qcom-apm CMD timeout [1001021]`, WCD938x UNATTACHED, `SWR bus clsh`, card probe -110.

- Reverting the RX/TX PM clock commits did not help.
- Suspects not tested: LPI pinctrl PM clock (7.2), `f64c5d5ff8f9d soundwire: qcom: set the bus mclk_freq`.

### Plymouth

- The clean image with `splash` hung in Plymouth. A message referred to ttyS0.
- ttyS0 was then removed. Plymouth with early msm is still not tested.
- Test not run: at GRUB, delete `splash`, add `plymouth.enable=0 systemd.show_status=1`. Report the result and the Caps Lock LED.

## Decisions

- The original plan kept firmware out of initramfs and removed msm and ADSP in a family hook. Test results disproved this plan.
- All x13s-specific settings are now in a thin board. `uefi-arm64-dt.conf` (family and board) has no changes.
- `MODULES=most` stays.
- The alsa-ucm hack and other userspace customizations are not ported.
- Steev `sc8280xp` cleanup was not done. It was to happen only after a passed boot test.

## Uncommitted state

`/Volumes/LinuxDev/armbian/armbian-build`, branch `extensions`:

- `config/boards/thinkpad-x13s.conf`: thin board. Sets `SERIALCON="tty1"`, `UEFI_GRUB_TERMINAL="gfxterm"`, `UEFI_GRUB_TIMEOUT=3`, `GRUB_CMDLINE_LINUX_DEFAULT="arm64.nopauth clk_ignore_unused"`. Adds an initramfs hook for the firmware above. The hook also removes `nvidia` firmware (154 MiB) from the initrd.
- `config/kernel/linux-uefi-arm64-dt-edge.config`: `CONFIG_VIDEO_OV5675=m`.
- `lib/functions/host/mountpoints.sh`: local Docker workaround. Do not commit.

`/Volumes/LinuxDev/armbian-separate/armbian-firmware`:

- Local branch `x13s-sc8280xp-blobs`, with 41 files staged. Not committed. Licenses not verified.

## Artifacts

- Latest image, not booted: `~/armbian-x13s/Armbian-unofficial_23.11.0-trunk_thinkpad-x13s_trixie_edge.img`, SHA256 `e5d6491a0e4ca9d9fbad093079649e5e5e3498b2849782da60a3796ff4376543`. Initrd is 50.6 MB.
- USB disk: previous image (with ttyS0, SHA256 starts `2030ff03`). This image hung.
- Build output: Docker volumes `armbian-output*`.
- Stray files: `/Volumes/LinuxDev/.gitconfig`, `output/x13s-remote.sh`, `output/x13s-status.txt`.

## Build

```sh
HOME=/Volumes/LinuxDev DOCKER_HOST=unix:///Users/rpardini/.colima/default/docker.sock \
  ./compile.sh build BOARD=thinkpad-x13s BRANCH=edge RELEASE=trixie \
  BUILD_MINIMAL=no BUILD_DESKTOP=no KERNEL_CONFIGURE=no BOARD_FIRMWARE_INSTALL=-full
```

- `lib/single.sh` refuses to run outside `$HOME` on macOS, so `HOME` is overridden. This causes a "Docker buildx not available" warning and created the stray `.gitconfig`.
- `GRUB_CMDLINE_LINUX_DEFAULT=` on the command line is mangled if the value contains `=`.
- Claude must run in the foreground under iTerm2. The `claude daemon run` process has no macOS Local Network access ("No route to host"). Fix: `claude daemon stop --any`, then resume in the foreground.

## Next steps, if resumed

1. Boot the latest image, or run the GRUB test above, to isolate Plymouth.
2. Test the two audio suspects.
3. Test the items listed as not tested.
4. Verify firmware licenses before any firmware commit.
5. Only after a passed boot test, do the `sc8280xp` cleanup.
