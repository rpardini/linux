#### kernel patching: 21 total patches; 21 applied; 10 with problems; 10 needs_rebase

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
|  🤖  ✅  | `[kernel-drivers/]` `sha1_40384c840ea1944d7c5a392e8975ed088ecf0b37_rockchip-rk3588_edge_0531084d_64e831fc-01ba4719` | `(+0/-0)[]` | 42077501ad833750abf513f30d5db57a611e6308 `?` | `Armbian Autopatcher` _[AUTOGEN] /armbian/cache/patch/kernel-drivers/sha1_40384c840ea1944d7c5a392e8975ed088ecf0b37_rockchip-rk3588_edge_0531084d_64e831fc-01ba4719_ |
| ✅  | `0001-general-add-overlay-support` | `(+19/-2)[2M]` | 68c4511a766d2a106248a8b4d09af0f3b59fd452 `Makefile.dtbinst`, `Makefile.dtbs` | `Paolo Sabatino` _compile .scr and install overlays in right path_ |
| ✅  | `0010-fix-clk-divisions` | `(+11/-0)[1M]` | 3dd403312e5d4115e42571021546ac579a3b8e23 `math.h` | `Sebastian Reichel` _math.h: add DIV_ROUND_UP_NO_OVERFLOW_ |
| ⚠️`[needs_rebase]`  | `0010-fix-clk-divisions` | `(+3/-3)[1M]` | 46bb5c8bd640fa7f4152c2e3a5aed8a4b52183f0 `clk-divider.c` | `Sebastian Reichel` _clk: divider: Fix divisor masking on 64 bit platforms_ |
| ✅  | `0010-fix-clk-divisions` | `(+2/-4)[1M]` | 3b5ae418f3b7bf31b6fa96b9ff3151a56a19f389 `clk-composite.c` | `Sebastian Reichel` _clk: composite: replace open-coded abs_diff()_ |
| ✅  | `0027-RK3588-Add-rkvdec2-Support-v3` | `(+510/-499)[1M, 1A]` | fde2403c61e5bd5f07e0b31e2ecc9b153b97f56f `rkvdec-h264-cabac.h`, `rkvdec-h264.c` | `Detlev Casanova` _media: rockchip: Move H264 CABAC table to header file_ |
| ⚠️`[needs_rebase]`  | `0027-RK3588-Add-rkvdec2-Support-v3` | `(+2496/-0)[2M, 7A]` | 207073e6b5a105e29261cb1491bb3c89835b9f29 `rkvdec2.c`, `rkvdec2-h264.c`, `rkvdec2-regs.h`, `rkvdec2.h`, `Kconfig`, `TODO`, `Makefile` | `Detlev Casanova` _media: rockchip: Introduce the rkvdec2 driver_ |
| ⚠️`[needs_rebase]`  | `0027-RK3588-Add-rkvdec2-Support-v3` | `(+50/-0)[1M]` | eecd9f934c0ba37a80de051c8cfa75fd6176825d `rk3588-base.dtsi` | `Detlev Casanova` _arm64: dts: rockchip: Add rkvdec2 Video Decoder on rk3588(s)_ |
| ✅  | `0028-media-v4l2-core-Initialize-h264-frame_mbs_only_flag-` | `(+13/-0)[1M]` | 682f733935935e7c1ee09896e5c9c1867d365f5d `v4l2-ctrls-core.c` | `amazingfate` _media: v4l2-core: Initialize h264 frame_mbs_only_flag as 1_ |
| ⚠️`[needs_rebase]`  | `0802-wireless-add-clk-property` | `(+10/-0)[1M]` | 5a48bb0271ea10d5c8aa8a2b77c4e3e5a4026381 `pcie.c` | `Ondrej Jirman` _net: wireless: brcmfmac: Add optional 32k clock enable support_ |
| ⚠️`[needs_rebase]`  | `1010-arm64-dts-rock-5b-Slow-down-emmc-to-hs200-and-add-ts` | `(+5/-2)[1M]` | 48865a92d057664ae1401acc2048cdaf3294cc65 `rk3588-rock-5b.dts` | `amazingfate` _arm64: dts: rock-5b: Slow down emmc to hs200 and add tsadc node_ |
| ⚠️`[needs_rebase]`  | `1032-arm64-dts-rockchip-Add-ap6275p-wireless-support-to-A` | `(+16/-0)[1M]` | 7c6b9cccf7c82cdf9a525028b5e9546122042aac `rk3588-armsom-sige7.dts` | `Jianfeng Liu` _arm64: dts: rockchip: Add ap6275p wireless support to ArmSoM Sige7_ |
| ✅  | `1041-board-khadas-edge2-mcu` | `(+30/-2)[2M]` | bca358d2f00e5a1d44ddba4cd137d21c7eda2a6e `khadas-mcu.h`, `khadas-mcu.c` | `Muhammed Efe Cetin` _mfd: khadas-mcu: add Edge2 registers_ |
| ✅  | `1041-board-khadas-edge2-mcu` | `(+0/-11)[1M]` | e9eb796ca08e279bd8483fae4c8a9372c9e6ab82 `khadas-mcu.c` | `Muhammed Efe Cetin` _mfd: khadas-mcu: drop unused code_ |
| ✅  | `1041-board-khadas-edge2-mcu` | `(+73/-4)[1M]` | a99dd06f64cc49fa4ef2669732adba232d914992 `khadas_mcu_fan.c` | `Muhammed Efe Cetin` _thermal: khadas_mcu_fan: add support for Khadas Edge 2_ |
| ✅  | `1041-board-khadas-edge2-mcu` | `(+6/-1)[1M]` | 1e575bf083c6a57dfaa54a9588a2ea37b40c20f5 `khadas,mcu.yaml` | `Muhammed Efe Cetin` _dt-bindings: mfd: khadas-mcu: add cooling-levels property_ |
| ⚠️`[needs_rebase]`  | `1041-board-khadas-edge2-mcu` | `(+7/-0)[1M]` | 8016718ad01f993c19bf21acec8ee07ef6f81636 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add MCU to Khadas Edge 2_ |
| ⚠️`[needs_rebase]`  | `1041-board-khadas-edge2-mcu` | `(+56/-0)[1M]` | 7ad910e70bc208605ecd0306a229855b8d66f989 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add automatic fan control to Khadas Edge 2_ |
| ✅  | `1062-arm64-dts-rockchip-Enable-GPU-node-on-Turing-RK1` | `(+5/-0)[1M]` | e0683a52a9b26b3722d73b54b244ccda9efb3e2d `rk3588-turing-rk1.dtsi` | `Joshua Riek` _arm64: dts: rockchip: Enable GPU node on Turing RK1_ |
| ⚠️`[needs_rebase]`  | `1063-arm64-dts-rockchip-Enable-automatic-fan-control-on-t` | `(+31/-1)[1M]` | 09c0cc8902a63eb69b96067aa0533008b9910423 `rk3588-turing-rk1.dtsi` | `Joshua Riek` _arm64: dts: rockchip: Enable automatic fan control on the Turing RK1_ |
| ⚠️`[needs_rebase]`  | `1064-arm64-dts-rockchip-Add-missing-hym8563-clock-frequen` | `(+1/-0)[1M]` | c8e4e1c0632ac21077258a6025765ab29572f834 `rk3588-turing-rk1.dtsi` | `Joshua Riek` _arm64: dts: rockchip: Add missing hym8563 clock-frequency for Turing RK1_ |


