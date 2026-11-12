# snps_hdmirx (RK3588 HDMI RX): CEC adapter gets the source's physical address

Found 2026-11-12 while testing K23 (MT8195 CEC) with the Mixtile Blade 3 HDMI-in as the CEC partner. Status ID: K24. Not started.

## Symptom

- Blade 3 (`blade3a`, 192.168.66.145, Armbian `7.3.1-edge-rockchip64`), `/dev/cec1` = `snps_hdmirx`, default EDID (`CONFIG_VIDEO_SYNOPSYS_HDMIRX_LOAD_DEFAULT_EDID=y`, `LNX hdmi-4k-300`).
- The EDID gives the connected source PA **1.0.0.0**. The RX adapter itself also reports PA **1.0.0.0**.
- `cec-ctl -d1 --tv` → LA **14 (Specific)**, not 0: the CEC core only gives a TV LA 0 when its PA is 0.0.0.0.
- The sink's own PA should be the *parent* of the PA in the EDID it serves (here 0.0.0.0).

## Cause (v7.4-rc1+ tree, `drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c`)

- `hdmirx_write_edid_data()` calls `cec_s_phys_addr_from_edid(adap, edid)`. That sets the adapter's PA to the PA *inside* the EDID, which is the source's address.
- `hdmirx_set_edid()` already computes the parent: `v4l2_phys_addr_validate(phys_addr, &phys_addr, NULL)`. The result is then dropped.
- Both the default-EDID path and `VIDIOC_S_EDID` go through `hdmirx_write_edid_data()`.
- Present since the driver was added: `7b59b132ad43` "media: platform: synopsys: Add support for HDMI input driver".

## Consequences seen in the K23 test

- `cec-follower -d1` on the Blade 3 doesn't act as a TV, because it is on LA 14 and not 0. It ignores Image/Text View On (no wake from standby) and doesn't Feature Abort System Audio Mode. So `cec-compliance -r 14` from the NIO fails "Wake up TV on Image View On / Text View On" and "Set System Audio Mode (directly addressed)".

## Related: broadcasts rejected by the Blade 3's own TX CEC

- With a second cable from the Blade 3's HDMI TX (`dwhdmiqp`, `/dev/cec0`, unconfigured, PA f.f.f.f) to the NIO's HDMI RX, every broadcast from the Blade 3 RX adapter ended in NACK/Max Retries. The NIO RX connector seems to share the CEC line with its TX connector.
- Still the same with the NIO's adapter unconfigured. Unplugging the Blade 3's TX cable fixed it.
- Suspect: the dw-hdmi-qp CEC (Rockchip) pulls ACK low on broadcasts (= reject) even while unconfigured/disabled. Check `dw_hdmi_qp` CEC enable/disable and its logical address register reset value. Test: Blade 3 TX → another CEC device, `cec-ctl -d0` unconfigured, broadcasts from the other side.

## Reference pattern

- `drivers/media/i2c/adv7604.c`: `pa = cec_get_edid_phys_addr(...)`, `v4l2_phys_addr_validate(pa, &parent_pa, NULL)`, then `cec_s_phys_addr(state->cec_adap, parent_pa, false)`. tc358743 and vivid do the same.

## Fix idea

- In `hdmirx_write_edid_data()` (or its callers): get the EDID PA with `cec_get_edid_phys_addr()`, validate it into `parent_pa`, and call `cec_s_phys_addr(adap, parent_pa, false)`.
- Check what happens when the EDID has no PA (`CEC_PHYS_ADDR_INVALID`): `v4l2_phys_addr_validate` accepts it. Keep the adapter invalid then.
- Fixes tag on `7b59b132ad43`; Cc Dmitry Osipenko / Shreeya Patel (driver authors), Hans Verkuil.

## Test

- Blade 3 RX ↔ NIO-12L TX (same setup as K23): after the fix, `cec-ctl -d1` on the Blade 3 shows PA 0.0.0.0, `--tv` gets LA 0, and the NIO still sees 1.0.0.0.
- `cec-compliance` on the RX adapter, with `cec-follower` on the source.
- Also try a custom EDID with `v4l2-ctl --set-edid` (eg. PA 2.0.0.0 → RX should still be 0.0.0.0).
