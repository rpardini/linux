#### kernel patching: 121 total patches; 121 applied; 0 with problems

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
|  🤖  ✅  | `[kernel-drivers/]` `sha1_98f7e32f20d28ec452afb208f9cffc08448a2652_rockchip64_edge_5aaf5b3f_64e831fc-01ba4719` | `(+0/-0)[]` | 8a17b226872e546cfb5c4cff7fd9705321c21917 `?` | `Armbian Autopatcher` _[AUTOGEN] /armbian/cache/patch/kernel-drivers/sha1_98f7e32f20d28ec452afb208f9cffc08448a2652_rockchip64_edge_5aaf5b3f_64e831fc-01ba4719_ |
| ✅  | `add-board-fine3399-dts` | `(+871/-0)[1A]` | 08c0503d95470f9275cb8dc56dc3ad6419089e87 `rk3399-fine3399.dts` | `Lemon1151` _Adding support for the fine3399 board_ |
| ✅  | `add-board-helios64` | `(+654/-80)[1M]` | 74416ea807ccf0772d9c60ec7bf59dc4912d8b3e `rk3399-kobol-helios64.dts` | `Aditya Prayoga` _Add board Helios64_ |
| ✅  | `add-board-xiaobao-nas-dts` | `(+774/-0)[1A]` | 27fa051bebaaac463ce59cbd7248fcac7e13fb10 `rk3399-xiaobao-nas.dts` | `Lemon` _Add board rk3399-xiaobao-nas_ |
| ✅  | `board-firefly-rk3399-dts` | `(+103/-30)[1M]` | 93edf69cbe60ff2e919fed2fab508dd6ec4d74f8 `rk3399-firefly.dts` | `chainsx` _[ARCHEOLOGY] firefly-rk3399: move to rockchip64 family_ |
| ✅  | `board-helios64-dts-fix-stability-issues` | `(+1/-0)[1M]` | 847dcd4d76a423c4263f6513de313a98d9f8be0f `rk3399-kobol-helios64.dts` | `Aditya Prayoga` _Attempt to improve stability on Helios64 (#2680)_ |
| ✅  | `board-helios64-remove-pcie-ep-gpios` | `(+0/-1)[1M]` | 36cfa9bbcac688653565ac099b3b431370794e6a `rk3399-kobol-helios64.dts` | `Aditya Prayoga` _Remove PCIE ep-gpios from Helios64_ |
| ✅  | `board-nanopc-t4-add-typec-dp` | `(+96/-0)[1M]` | 7c28825c3b488a15367c697b2a3116d6f93631c8 `rk3399-nanopc-t4.dts` | `tonymac32` _Patching something_ |
| ✅  | `board-nanopi-m4v2-dts-add-sound-card` | `(+60/-0)[2M]` | 99fe3d24f77230cb8cde5b75e6475fb0ec3ff1e5 `rk3399-nanopi4.dtsi`, `Kconfig` | `Piotr Szczepanik` _[ARCHEOLOGY] Initial addition of NanoPi M4V2_ |
| ✅  | `board-nanopi-r2c-plus` | `(+1/-1)[1M]` | e201360407d42fedffab2ca51dc0a8946998ee01 `rk3328-nanopi-r2c-plus.dts` | `amazingfate` _[ARCHEOLOGY] rockchip64: bump rockchip64-edge kernel to 6.5_ |
| ✅  | `board-nanopi-r2s` | `(+328/-165)[1M]` | 1cfa126555dec04f45dfe14454fb9c8d85280ab8 `rk3328-nanopi-r2s.dts` | `Paolo Sabatino` _rockchip64: consolidate nanopi r2s device trees_ |
| ✅  | `board-nanopi-r4s-pwmfan` | `(+35/-0)[1M]` | 69258db9b310fd0ea8d27c1b3e0100171fe2d3f4 `rk3399-nanopi-r4s.dts` | `Bochun Bai` _Add pwm-fan support to nanopi r4s_ |
| ✅  | `board-orangepi-r1-plus` | `(+45/-0)[1M]` | a79d7115fa0f3e863963c205f2b25de4084df8f9 `rk3328-orangepi-r1-plus.dts` | `Igor Pecovnik` _[ARCHEOLOGY] Initial ROCK Pi E support (as WIP) (#2042)_ |
| ✅  | `board-orangepi-rk3399-pcie` | `(+31/-0)[1M]` | 6363403e5137749e5a4a67b891fe4c452d86adc7 `rk3399-orangepi.dts` | `amazingfate` _arm64: dts: rockchip: add pcie support to orangepi rk3399 board_ |
| ✅  | `board-pbp-add-dp-alt-mode` | `(+210/-3)[4M]` | a84a987768c35cbc917f9236c4f19372a50e61fc `tcpm.c`, `displayport.c`, `phy-rockchip-typec.c`, `rk3399-pinebook-pro.dts` | `Dan Johansen` _add-dp-alt-mode-to-PBP_ |
| ✅  | `board-radxa-e25-sdmmc0-fix` | `(+1/-1)[1M]` | c9b22ad440616a38ba8b727d9a53258b12fe131d `rk3568-radxa-e25.dts` | `krachlatte` _[ARCHEOLOGY] Improve SD card compatibility on Radxa E25 (#5165)_ |
| ✅  | `board-radxa-e25-usb3-and-emmc-fix` | `(+14/-0)[2M]` | 7729bd6470ce119ade53c4ff35b583feb826bcce `rk3568-radxa-cm3i.dtsi`, `rk3568-radxa-e25.dts` | `krachlatte` _[ARCHEOLOGY] Improve SD card compatibility on Radxa E25 (#5165)_ |
| ✅  | `board-rk3328-roc-cc-dts-enable-dmc` | `(+38/-0)[1M]` | 33f8d2a65a8bac7ca069116ec69289cb1c6a457c `rk3328-roc-cc.dts` | `Paolo Sabatino` _enable roc-cc dmc_ |
| ✅  | `board-rk3328-roc-cc-dts-ram-profile` | `(+311/-0)[1A]` | 0fa8c8eae0cf1b91238c8b667e247d1c698ea13d `rk3328-dram-renegade-timing.dtsi` | `tonymac32` _board-rk3328-roc-cc-adjust-DMC-opps_ |
| ✅  | `board-rk3328-roc-pc-dts-ram-profile` | `(+223/-0)[1A]` | 29d6ba2eddb2d1c43e3bff3c341b4bfd93a99d3f `rk3328-roc-pc-dram-timing.dtsi` | `Tony` _[ARCHEOLOGY] Add files via upload_ |
| ✅  | `board-rk3328-roc-pc` | `(+466/-59)[1M]` | 165eef26e9cf7ae65dfc6fa285e02e98894f335c `rk3328-roc-pc.dts` | `Paolo Sabatino` _enable dmc for rk3328-roc-pc_ |
| ✅  | `board-rock3a-emmc-sfc` | `(+11/-0)[1M]` | 5cf439c4d94decec29765d2c03f82779977dde5b `rk3568-rock-3a.dts` | `Jianfeng Liu` _[ARCHEOLOGY] update rockchip64 edge to 5.19 (#4039)_ |
| ✅  | `board-rock3a-usb3` | `(+1/-0)[1M]` | 6e052835772bacd53f9e5b77ff6f679a8244ddf4 `rk3568-rock-3a.dts` | `Jianfeng Liu` _[ARCHEOLOGY] update rockchip64 edge to 5.19 (#4039)_ |
| ✅  | `board-rock64-mail-supply` | `(+5/-0)[1M]` | b3a993d354fc971e1b0c315421982acc54ed1c47 `rk3328-rock64.dts` | `tonymac32` _board_rock64_mali-usb-supply_ |
| ✅  | `board-rockpi3-enable-dmc` | `(+7/-0)[1M]` | b22613dd09bf950e1196ea0ff1cb1989a95948ba `rk3328-rock-pi-e.dts` | `Paolo Sabatino` _[ARCHEOLOGY] rockchip64: enable dmc on Rock PI E board_ |
| ✅  | `board-rockpi4-0003-arm64-dts-pcie` | `(+4/-0)[1M]` | f8bff0d0237a82c39ef354bae7d3cbc271df94e6 `rk3399-rock-pi-4.dtsi` | `Piotr Szczepanik` _[ARCHEOLOGY] Rock Pi 4 enable PCIe in device tree for "dev" target (#1624)_ |
| ✅  | `board-rockpie-0001-arm64-dts-rockchip-fix-gmac-PHY-attach-error` | `(+1/-0)[1M]` | 7f69632e01fb1591e1d88d3faaf1545edbd7e763 `rk3328-rock-pi-e.dts` | `FUKAUMI Naoki` _arm64: dts: rockchip: fix gmac PHY attach error on ROCK Pi E_ |
| ✅  | `board-rockpis-0005-arm64-dts-rk3308-Add-gmac-node-at-dtsi-level` | `(+1/-0)[1M]` | 154239d138e6fef1b64e4b631085a920e4bb9ca0 `rk3308.dtsi` | `ashthespy` _arm64: dts: rk3308: Add mac node at dtsi level_ |
| ✅  | `board-rockpis-0007-arm64-dts-rockchip-add-cpu-s-thermal-config-for-rk33` | `(+64/-0)[1M]` | 16bb666709472c0216f81c36f328519c1d7c0759 `rk3308.dtsi` | `ashthespy` _arm64: dts: rockchip: add cpu's thermal config for rk3308_ |
| ✅  | `board-rockpis-0008-thermal-rockchip-add-tsadc-support-for-rk3308` | `(+27/-0)[2M]` | ac43486e21b6d1a88036e9174a44a5ed4f796e6c `rockchip_thermal.c`, `rockchip-thermal.yaml` | `Rocky Hao` _thermal: rockchip: add tsadc support for rk3308_ |
| ✅  | `board-rockpis-0012-arm64-dts-rk3308-Add-rk-timer-rtc` | `(+9/-0)[1M]` | 969dfff0a04579f207cd4cbae0a52da2375d32a7 `rk3308.dtsi` | `ashthespy` _arm64: dts: rk3308: Add rk-timer-rtc_ |
| ✅  | `board-rockpis-0029-arm64-dts-rk3308-add-reserved-memory-ramoops` | `(+20/-0)[1M]` | 84e1f0fe047044334fada83196bfabde2a434e19 `rk3308.dtsi` | `Igor Pecovnik` _[ARCHEOLOGY] Bumping EDGE kernel to 5.14.y (#3125)_ |
| ✅  | `board-rockpro64-0001-Add-pcie-bus-scan-delay` | `(+1/-0)[1M]` | 3574c57e05e6a8520349b0d66660c062783cd373 `rk3399-rockpro64.dtsi` | `Piotr Szczepanik` _Rockpro64 add pcie bus scan delay_ |
| ✅  | `board-rockpro64-change-rx_delay-for-gmac` | `(+1/-1)[1M]` | a6db513e5ef60b2f508972a7ec05c0825506f2b3 `rk3399-rockpro64.dtsi` | `Ayufan` _ayufan: dts: rockpro64: change rx_delay for gmac_ |
| ✅  | `board-rockpro64-fix-emmc` | `(+2/-0)[1M]` | 415116170da2ac21f2a9a4c32f0215350f4e709e `rk3399-rockpro64.dtsi` | `Martin Ayotte` _[ARCHEOLOGY] fix PMIC_INT_L gpio conflicting with I2C8_SCL in RockPro64_ |
| ✅  | `board-rockpro64-fix-spi1-flash-speed` | `(+1/-1)[1M]` | 26ef8bf593680420fdcb90c07a8e823d948d719e `rk3399-rockpro64.dtsi` | `Martin Ayotte` _[ARCHEOLOGY] slow SPIFlash to avoid errors_ |
| ✅  | `board-rockpro64-work-led-heartbeat` | `(+1/-1)[1M]` | 9483c6b5f8256a0e6e29cf10aafaa1da0e41ae44 `rk3399-rockpro64.dtsi` | `Piotr Szczepanik` _[ARCHEOLOGY] Switch RockPro64 work led to heartbeat trigger_ |
| ✅  | `board-rocks0-0001-deviceTree` | `(+200/-146)[1M]` | 98ae36ae8e2b21a31ba999c3897ff71f36afe8ac `rk3308-rock-s0.dts` | `Brent Roman` _Added Linux device tree for Rock S0_ |
| ✅  | `board-station-p2` | `(+325/-55)[1M]` | 299489862223abc9a64d0b8f088baf3624472b22 `rk3568-roc-pc.dts` | `chainsx` _[ARCHEOLOGY] fix rk3568-roc-pc_ |
| ✅  | `drv-spi-spidev-remove-warnings` | `(+2/-0)[1M]` | 6e598e259346e9736c6a54d60247a0ab9e608f9d `spidev.c` | `John Doe` _rockchip64: edge: 6.10.5 drv:spi:spidev remove warnings_ |
| ✅  | `general-add-miniDP-dt-doc` | `(+66/-0)[1A]` | 9f134ccfef20aadb68a0600fcd0573600966a57e `extcon-usbc-virtual-pd.yaml` | `Tony` _[ARCHEOLOGY] RK3399 Typec DP (#2676)_ |
| ✅  | `general-add-miniDP-virtual-extcon` | `(+296/-0)[2M, 1A]` | 878540c827b79a1d95936385b3a76402be554b44 `extcon-usbc-virtual-pd.c`, `Kconfig`, `Makefile` | `Tony` _[ARCHEOLOGY] RK3399 Typec DP (#2676)_ |
| ✅  | `general-add-overlay-compilation-support` | `(+19/-2)[2M]` | 3932e6635b0a45d3c93033d7fb7ed39feeffa70a `Makefile.dtbinst`, `Makefile.lib` | `Paolo Sabatino` _compile .scr and install overlays in right path_ |
| ✅  | `general-add-overlay-configfs` | `(+320/-0)[2M, 2A]` | 52167ad05320255eda908b5fe8c4f05787405f92 `configfs.c`, `configfs-overlays.txt`, `Kconfig`, `Makefile` | `Pantelis Antoniou` _OF: DT-Overlay configfs interface_ |
| ✅  | `general-add-panel-simple-dsi` | `(+773/-0)[1M, 1A]` | a23317f839db2969d992b5058b17a59d7de39c89 `panel-simple-dsi.c`, `Makefile` | `simple` _[ARCHEOLOGY] general add panel simple dsi (#3140)_ |
| ✅  | `general-add-pll-hdmi-timings` | `(+71/-0)[1M]` | 6beaf079a3717641edfff5a62836c753e3b5e2de `phy-rockchip-inno-hdmi.c` | `paolo` _[ARCHEOLOGY] Adding pll hdmi timing to rockchip64-dev too_ |
| ✅  | `general-add-xtx-spi-nor-chips` | `(+24/-0)[3M, 1A]` | a8f46ffc1209b53b9b69416d3f1665558644fd10 `xtx.c`, `Makefile`, `core.c`, `core.h` | `microcai` _spi-nor: Add support for xt25f32b/xt25f128b_ |
| ✅  | `general-cryptov1-trng` | `(+140/-1)[6M, 1A]` | 3c0ae1ca5e874b7881eb203266181b17e4f7b4e8 `rk3288_crypto_trng.c`, `rk3288_crypto.c`, `rk3288_crypto.h`, `Kconfig`, `rk3288_crypto_ahash.c`, `rk3288_crypto_skcipher.c`, `Makefile` | `Paolo Sabatino` _rockchip64: add TRNG to existing crypto v1 driver_ |
| ✅  | `general-disable-mtu-validation` | `(+0/-12)[1M]` | 64bd41bcda1a0ff537d6899b35e8c3f9a8e5866b `stmmac_main.c` | `Igor Pecovnik` _Disable MTU validation_ |
| ✅  | `general-fix-es8316-kernel-panic` | `(+1/-1)[1M]` | e7a96d036fef7cbb3f08768e928067580579de72 `es8316.c` | `Yannick Adam` _[ARCHEOLOGY] Enable es8316 on RockPi4 (#1885)_ |
| ✅  | `general-fix-inno-usb2-phy-init` | `(+0/-5)[1M]` | fca92ea29eef1b096bfc419c1f50137eeb69dd8e `phy-rockchip-inno-usb2.c` | `Paolo Sabatino` _remove usb2phy extcon initialization causing kernel oops_ |
| ✅  | `general-fix-mmc-signal-voltage-before-reboot` | `(+8/-0)[1M]` | 8ef026b05b28f54b12f3e27e209f3bdeefa7412f `core.c` | `Jonas Karlman` _mmc: core: set initial signal voltage on power off_ |
| ✅  | `general-hdmi-clock-fixes` | `(+109/-18)[5M]` | 200154de2175c63dd34963e3c72c1cf29a985964 `clk-rk3399.c`, `dw_hdmi-rockchip.c`, `rockchip_drm_vop.c`, `dw-hdmi.c`, `rockchip_vop_reg.c` | `Paolo Sabatino` _hdmi timing core changes and fixes_ |
| ✅  | `general-hdmi-clock-fixes` | `(+67/-78)[1M]` | 7203283840c3e654d4e127c5680589478a3ed102 `dw_hdmi-rockchip.c` | `Miouyouyou` _[ARCHEOLOGY] [RFC] RK3288 : Add HDMI resolutions (#1887)_ |
| ✅  | `general-increasing_DMA_block_memory_allocation_to_2048` | `(+3/-5)[1M]` | 334a7a8c508b318e40c7dd972a5005756426311a `pool.c` | `Igor Pecovnik` _[ARCHEOLOGY] Increasing DMA block memory allocation to 2048k on all relevant kernels._ |
| ✅  | `general-legacy-rockchip-hwrng` | `(+359/-0)[3M, 1A]` | aa6702460934aba0fb825258270196658978225d `rockchip-rng.c`, `rk3308.dtsi`, `Kconfig`, `Makefile` | `brentr` _[ARCHEOLOGY] Restored Hardware Random Number Generator from legacy (4.4) kernel (#4286)_ |
| ✅  | `general-legacy-rockchip-hwrng_5.10` | `(+249/-79)[1M]` | e66aba5d6c5f870557547eb7a4c65c60cd589a1e `rockchip-rng.c` | `brentr` _[ARCHEOLOGY] Updated v4.4 HW RND driver with that from v5.10 kernel (#4485)_ |
| ✅  | `general-possibility-of-disabling-rk808-rtc` | `(+2/-1)[2M]` | 8b11de3d650f12e2a0153fc7525338aa4fcec78f `mfd-core.c`, `rk8xx-core.c` | `Piotr Szczepanik` _add possibility of disabling rk808-rtc_ |
| ✅  | `general-rk3328-dtsi-trb-ent-quirk` | `(+1/-0)[1M]` | a27ef5f62b593d344da4407729338ac306ce51d9 `rk3328.dtsi` | `schwar3kat` _[ARCHEOLOGY] Enable rockchip64: XHCI HCD USB TRB ENT quirk for RK3328 (#3763)_ |
| ✅  | `general-rk808-configurable-switch-voltage-steps` | `(+13/-4)[1M]` | 0111ad34ca3640c276d8d50d74f062311189f1d3 `rk808-regulator.c` | `Piotr Szczepanik` _allows to change the way that BUCK1 and BUCK2 of rk808 PMIC_ |
| ✅  | `general-rockchip-overlays` | `(+3/-0)[1M]` | 4f532ba2e0759b73aa8f0d8f4b40ecc30042e3d7 `Makefile.lib` | `Martin Ayotte` _add overlays framework for rockchip (scripts/Makefile.lib only)_ |
| ✅  | `general-rt5651-add-mclk` | `(+17/-0)[2M]` | 6a6bd9a4b6b99b66a454ceeb403f83b5581be884 `rt5651.c`, `rt5651.h` | `Piotr Szczepanik` _[ARCHEOLOGY] Fixed sound from rt5651 on OrangePi 4 (#1870)_ |
| ✅  | `general-v4l2-iep-driver` | `(+1632/-1)[5M, 6A]` | 446f9d2c83a5b4f300c809cd94c8aa5b00f6ea16 `iep.c`, `iep-regs.h`, `iep.h`, `rockchip-iep.yaml`, `rk3328.dtsi`, `rk3288.dtsi`, `rk3399.dtsi`, `Kconfig`, `Makefile` | `Paolo` _Rockchip IEP driver_ |
| ✅  | `general-v4l2-rkvdec-00-fixes` | `(+38/-39)[1M]` | a056ed1325c723021c52fcbae65c7ca2b43cd767 `v4l2-common.c` | `Jonas Karlman` _media: v4l2-common: Add helpers to calculate bytesperline and sizeimage_ |
| ✅  | `general-v4l2-rkvdec-00-fixes` | `(+8/-0)[3M]` | 8da0e2f63f5cd7435f2b74ee458d142d45ffa781 `v4l2-common.c`, `videodev2.h`, `v4l2-ioctl.c` | `Jonas Karlman` _media: v4l2: Add NV15 and NV20 pixel formats_ |
| ✅  | `general-v4l2-rkvdec-00-fixes` | `(+5/-5)[1M]` | c5f7ebc1fe101e70a70d51fc79f43caa98eebb0b `rkvdec-h264.c` | `Jonas Karlman` _media: rkvdec: h264: Use bytesperline and buffer height to calculate stride_ |
| ✅  | `general-v4l2-rkvdec-00-fixes` | `(+15/-14)[1M]` | 2a478d0b8e73d7ce56bc09c94f1917301e5a316f `rkvdec.c` | `Jonas Karlman` _media: rkvdec: Extract rkvdec_fill_decoded_pixfmt helper method_ |
| ✅  | `general-v4l2-rkvdec-00-fixes` | `(+61/-8)[2M]` | f77cb0572a6e4ac1d4c24c78d1068075b568d09b `rkvdec.c`, `rkvdec.h` | `Jonas Karlman` _media: rkvdec: Lock capture pixel format in s_ctrl and s_fmt_ |
| ✅  | `general-v4l2-rkvdec-00-fixes` | `(+37/-15)[2M]` | e7d5c3fa450ec5d49eda088523971bae0c3ee927 `rkvdec-h264.c`, `rkvdec.c` | `Jonas Karlman` _media: rkvdec: h264: Support High 10 and 4:2:2 profiles_ |
| ✅  | `general-v4l2-rkvdec-00-fixes` | `(+7/-6)[1M]` | b796f48f9edd35ea970b52f0ec404383e94ddf78 `rkvdec-h264.c` | `Alex Bee` _media: rkvdec-h264: Don't hardcode SPS/PPS parameters_ |
| ✅  | `general-v4l2-rkvdec-01-vp9` | `(+2/-2)[1M]` | 17afad184feaa4a4c5237255c3d44a6ae8a36d7b `rkvdec.c` | `Jonas Karlman` _WIP: media: rkvdec: pm runtime dont use autosuspend before disable and cleanup_ |
| ✅  | `general-v4l2-rkvdec-01-vp9` | `(+44/-0)[2M, 1A]` | 2b7ded2d19eb186f20431f3dd29d4b9332772c9f `pm-domains.c`, `rockchip_pmu.h`, `pm_domains.h` | `Randy Li` _soc: rockchip: power-domain: export idle request_ |
| ✅  | `general-v4l2-rkvdec-01-vp9` | `(+87/-1)[4M]` | 34cd4ff40bd8069d1bda09752eb77e05c28c7c04 `rkvdec.c`, `rockchip,vdec.yaml`, `rkvdec.h`, `rkvdec-regs.h` | `Alex Bee` _WIP: media: rkvdec: implement reset controls_ |
| ✅  | `general-v4l2-rkvdec-01-vp9` | `(+11/-3)[1M]` | 74d09018de9b9152ddbd720de848dfb72ef4271b `rockchip_vpu_hw.c` | `Alex Bee` _media: hantro: rockchip: Increase RK3288's max ACLK_ |
| ✅  | `general-v4l2-rkvdec-01-vp9` | `(+10/-0)[2M]` | ad850357e6acb98c1a52989e6659d0df6cc58374 `rkvdec-vp9.c`, `rkvdec-regs.h` | `Alex Bee` _media: rkvdec: disable QoS for VP9 (corruptions on RK3328 otherwise)_ |
| ✅  | `general-v4l2-rkvdec-01-vp9` | `(+5/-0)[1M]` | 5a12fd45401a181440a1fb97e676ba543c584ddb `rk3328.dtsi` | `Alex Bee` _WIP: arm64: dts: add resets to vdec for RK3328_ |
| ✅  | `general-v4l2-rkvdec-02-hevc` | `(+2647/-2)[4M, 1A]` | 14e2159796f939a594a89c4ca3f84d30bd0a3c2d `rkvdec-hevc.c`, `rkvdec.c`, `Makefile`, `rkvdec-regs.h`, `rkvdec.h` | `Jonas Karlman` _WIP: media: rkvdec: add HEVC backend_ |
| ✅  | `general-v4l2-rkvdec-02-hevc` | `(+85/-30)[2M]` | 3c8528cabe575ee3a249cb2cc87dbf2bba2e70ce `rkvdec.c`, `rkvdec.h` | `Alex Bee` _media: rkvdec: add variants support_ |
| ✅  | `general-v4l2-rkvdec-02-hevc` | `(+8/-0)[1M]` | e728beb0a8cf9e711aec47c2d9d3d2d78bbaf1be `rkvdec.c` | `Alex Bee` _media: rkvdec: add RK3288 variant_ |
| ✅  | `general-v4l2-rkvdec-02-hevc` | `(+20/-1)[1M]` | 688d88b71093efa392b49e292e1592c53fce9f4b `rk3288.dtsi` | `Alex Bee` _ARM: dts: RK3288: add hevc node_ |
| ✅  | `general-v4l2-rkvdec-02-hevc` | `(+23/-3)[1M]` | da489a8b3e9d6e4ad04207155147d42d0debd916 `rkvdec-hevc.c` | `Nicolas Dufresne` _media: rkvdec: Fix HEVC RPS bit offsets_ |
| ✅  | `general-v4l2-rkvdec-02-hevc` | `(+4/-2)[1M]` | b077765424b6ac6ba774b3fc75f8185ea573eb95 `rkvdec-hevc.c` | `Nicolas Dufresne` _media: rkvdec: Fix number of HEVC references being set in RPS_ |
| ✅  | `general-workaround-broadcom-bt-serdev` | `(+1/-1)[1M]` | c449babe1967ac88947857821fb7e5372f0ea7c3 `btbcm.c` | `Paolo Sabatino` _Workaround to make several broadcom bluetooth serdev devices work even without proper MAC address_ |
| ✅  | `kernel-6.8-tools-cgroup-makefile` | `(+11/-0)[1A]` | 2dd3b249b9989a92b1139b6298a759c2ce94e339 `Makefile` | `Paolo Sabatino` _[ARCHEOLOGY] rockchip: bump edge kernel to 6.8_ |
| ✅  | `media-0001-Add-rkvdec2-Support-v3` | `(+510/-499)[1M, 1A]` | 68447a7731cc396f0d12dab63dbe67e1c1f2d73f `rkvdec-h264-cabac.h`, `rkvdec-h264.c` | `Detlev Casanova` _media: rockchip: Move H264 CABAC table to header file_ |
| ✅  | `media-0001-Add-rkvdec2-Support-v3` | `(+2496/-0)[2M, 7A]` | 6804bab7b12f9705234793c8f830fe0d1222a37b `rkvdec2.c`, `rkvdec2-h264.c`, `rkvdec2-regs.h`, `rkvdec2.h`, `Kconfig`, `TODO`, `Makefile` | `Detlev Casanova` _media: rockchip: Introduce the rkvdec2 driver_ |
| ✅  | `media-0001-Add-rkvdec2-Support-v3` | `(+48/-0)[1M]` | 4493d8e7dbc150126ba35247bb1ab14f0c03467f `rk3588-base.dtsi` | `Detlev Casanova` _arm64: dts: rockchip: Add rkvdec2 Video Decoder on rk3588(s)_ |
| ✅  | `media-0002-v4l2-core-Initialize-h264-frame_mbs_only_flag-` | `(+13/-0)[1M]` | 9421d6f0e75b478a6d31bbc1cfedb50a8d49c0c3 `v4l2-ctrls-core.c` | `amazingfate` _media: v4l2-core: Initialize h264 frame_mbs_only_flag as 1_ |
| ✅  | `media-0003-rk3568-disable-hantro-h264` | `(+3/-20)[3M]` | 71f4ffaeea861c594313a60b3322c01fffee14eb `rockchip_vpu_hw.c`, `hantro_drv.c`, `hantro_hw.h` | `amazingfate` _[ARCHEOLOGY] rockchip64-edge: disable hantro g1 h264 decoder on rk356x_ |
| ✅  | `net-usb-r8152-add-LED-configuration-from-OF` | `(+23/-0)[1M]` | 317b752fc36e7b5378bbd25d470dc0d06fa3d614 `r8152.c` | `David Bauer` _net: usb: r8152: add LED configuration from OF_ |
| ✅  | `regulator-add-fan53200-driver` | `(+533/-0)[3M, 1A]` | f693f2fb5afb94ba4743da8518f743a93d4ded4d `fan53200.c`, `Kconfig`, `defconfig`, `Makefile` | `Rock Shen` _regulator: add fan53200 regulator driver for Tinkerboard-2_ |
| ✅  | `rk3308-0001-pinctrl-slew-mux` | `(+100/-0)[4M]` | 6e79efbf5e63f10c3171c733f89b0ac1dbf878c6 `pinctrl-rockchip.c`, `pinctrl-rockchip.h`, `pinconf-generic.c`, `pinconf-generic.h` | `brentr` _[ARCHEOLOGY] Rockpis wifi fixes (#4008)_ |
| ✅  | `rk3308-0002-iodomains` | `(+45/-0)[1M]` | 71e5fdf1ab14a27a16bab2f642d95290c704d21d `io-domain.c` | `brentr` _[ARCHEOLOGY] Rockpis wifi fixes (#4008)_ |
| ✅  | `rk3308-0003-pinctrl-io-voltage-domains` | `(+24/-45)[2M]` | b461d2e02beea5bf7b3c22bb39baf0087261b133 `io-domain.c`, `pinctrl-rockchip.c` | `brentr` _[ARCHEOLOGY] Rockpis wifi fixes (#4008)_ |
| ✅  | `rk3308-add-missing-i2s-controllers` | `(+59/-0)[1M]` | 986b40093203a4daf91013191d0b5b55ef1be324 `rk3308.dtsi` | `Paolo Sabatino` _add missing i2s controllers_ |
| ✅  | `rk3328-add-dmc-driver` | `(+1692/-14)[8M, 6A]` | 2e83950db7378aec71232cab4e676db2840ca1d3 `rk3328_dmc.c`, `rk3328-dram-default-timing.dtsi`, `rk3328-dram.h`, `clk-ddr.c`, `rockchip-dfi.c`, `rockchip-ddr.h`, `rk3328.dtsi`, `rk3228_grf.h`, `rk3328_grf.h`, `clk-rk3328.c`, `Kconfig`, `rockchip_sip.h`, `clk.h`, `Makefile` | `Paolo Sabatino` _rk3328 dmc driver_ |
| ✅  | `rk3328-add-rga-node` | `(+14/-0)[1M]` | 1c099ec48ee8d0b9a857aaf852c022ed66327d7b `rk3328.dtsi` | `Paolo Sabatino` _rk3328: add RGA node_ |
| ✅  | `rk3328-dtsi-mali-opp-table` | `(+25/-0)[1M]` | b1b770d5c501f278d96ee46520bf2d1e986d5c83 `rk3328.dtsi` | `Paolo Sabatino` _gpu operating points_ |
| ✅  | `rk3328-dtsi-mmc-reset-properties` | `(+6/-0)[1M]` | 11f389e3733a9bc73b1cfc5d1bf466888916a09f `rk3328.dtsi` | `Paolo Sabatino` _mmc reset properties_ |
| ✅  | `rk3328-dtsi-sdmmc-ext-node` | `(+14/-0)[1M]` | 612351b33b3e5444ac17f47c2bbe62d4bc70779d `rk3328.dtsi` | `Paolo Sabatino` _sdmmc-ext node_ |
| ✅  | `rk3328-dtsi-spdif` | `(+27/-0)[1M]` | 788ea8aab13cc52cd33cd54a67822b718340537f `rk3328.dtsi` | `Paolo Sabatino` _[ARCHEOLOGY] rockchip64: tidy up rk3328 patches_ |
| ✅  | `rk3328-dtsi-usb3-reset-properties` | `(+2/-0)[1M]` | bb4bd64e0baa136e64c026a470c6d7d846207f3e `rk3328.dtsi` | `Paolo Sabatino` _usb3 reset properties_ |
| ✅  | `rk3328-gpu-cooling-target` | `(+6/-0)[1M]` | ac10a3d988075d684f9be34c75d734012e3352c9 `rk3328.dtsi` | `tonymac32` _rk3328-gpu-cooling-target_ |
| ✅  | `rk3328-roc-cc-add-missing-nodes` | `(+32/-0)[1M]` | a1994383cf5fb5eeb4401944da8b6f83e28361dc `rk3328-roc-cc.dts` | `tonymac32` _rk3328-roc-cc add missing nodes_ |
| ✅  | `rk3399-add-sclk-i2sout-src-clock` | `(+2/-1)[2M]` | 4884169d549eef0b84195bc54a67fd2ed021c03c `clk-rk3399.c`, `rk3399-cru.h` | `Piotr Szczepanik` _[ARCHEOLOGY] Fixed sound from rt5651 on OrangePi 4 (#1870)_ |
| ✅  | `rk3399-dmc-polling-rate` | `(+1/-1)[1M]` | 4b72a7eee6e3459e614c6a9588048a558fefac77 `rk3399_dmc.c` | `Paolo Sabatino` _[ARCHEOLOGY] rockchip64: set poll rate 50ms for rk3399 dmc driver_ |
| ✅  | `rk3399-enable-dwc3-xhci-usb-trb-quirk` | `(+2/-0)[1M]` | 5941cfa8b2e07e6ee3aedb149364f534dae40d95 `rk3399.dtsi` | `Aditya Prayoga` _[ARCHEOLOGY] Fix 2.5G Ethernet on Helios64 Mainline kernel (#2567)_ |
| ✅  | `rk3399-fix-pci-phy` | `(+16/-0)[1M]` | 9c07d2569e4f43178b8dbd1c4f7b054e3ad99436 `phy-rockchip-pcie.c` | `Andrey Safonov` _rk3399 PCIE PHY reset on probe_ |
| ✅  | `rk3399-fix-usb-phy` | `(+1/-1)[1M]` | 10b8bf6297592efee0c3299df88315f2a46efb1e `phy-rockchip-typec.c` | `Paolo Sabatino` _increase timeout for usb3 type C phy init_ |
| ✅  | `rk3399-rp64-pcie-Reimplement-rockchip-PCIe-bus-scan-delay` | `(+41/-0)[4M]` | a13960ce02f6514b24df4b88684f7ec0faacee07 `pcie-rockchip-host.c`, `kernel-parameters.txt`, `pcie-rockchip.c`, `pcie-rockchip.h` | `Dan Pasanen` _[ARCHEOLOGY] rockchip-[current,edge]: add pcie hack and lsi scsi/sas support (#3351)_ |
| ✅  | `rk3399-sd-drive-level-8ma` | `(+8/-8)[1M]` | 34f0a34c1203e112f942ca4202b4971d67a0bb78 `rk3399.dtsi` | `Martin Ayotte` _[ARCHEOLOGY] add better strength on SDCard and put back previous speed setting_ |
| ✅  | `rk3399-sd-pwr-pinctrl` | `(+5/-0)[1M]` | 9808b1ab91a247878c4cf1d54f4173cf49d27813 `rk3399.dtsi` | `Paolo Sabatino` _rk3399: add sd power pin to pinctrl node_ |
| ✅  | `rk3399-unlock-temperature` | `(+3/-3)[1M]` | 6ec0fbf6ea643075013024d861a7ca7b5f53d172 `rk3399.dtsi` | `ThomasKaiser` _[ARCHEOLOGY] Increase performance with rk3399-dev_ |
| ✅  | `rk356x-add-rkvdec2-support` | `(+33/-1)[1M]` | 82c2c2e834122fb78c338559d0fe50667786204d `rk356x.dtsi` | `amazingfate` _[ARCHEOLOGY] rockchip64-edge: add rkvdec2 for rk356x_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+65/-0)[1A]` | 3e197c4a8484b6fb518c0cf0302390b2f18ab465 `rockchip,rk3588-crypto.yaml` | `Corentin Labbe` _dt-bindings: crypto: add support for rockchip,crypto-rk3588_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+12/-0)[1M]` | 382dace0a1d9dc6dac8ee67b0ce88c32c12ddd39 `rk3588-base.dtsi` | `Corentin Labbe` _ARM64: dts: rk3588: add crypto node_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+12/-0)[1M]` | b2ccc8e03ab20fd3a5ca63f57450af63ef91bbee `rk356x.dtsi` | `Corentin Labbe` _ARM64: dts: rk356x: add crypto node_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+34/-76)[2M]` | 15243568f66a0563c32c770483705f44e2f225da `rockchip,rk3588-cru.h`, `rst-rk3588.c` | `Corentin Labbe` _reset: rockchip: secure reset must be used by SCMI_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+1939/-0)[2M, 4A]` | 730b0e5e944f59b48b4bd63d4fb0bf399854296b `rk2_crypto.c`, `rk2_crypto_skcipher.c`, `rk2_crypto_ahash.c`, `rk2_crypto.h`, `Kconfig`, `Makefile` | `Corentin Labbe` _crypto: rockchip: add rk3588 driver_ |
| ✅  | `wifi-4003-add-bcm43342-chip` | `(+3/-0)[2M]` | 074f8a9df62b6e21482cdd4ab8a787c145c3c1d5 `sdio.c`, `brcm_hw_ids.h` | `Paolo Sabatino` _add broadcom bcm43342 chip id_ |
| ✅  | `wifi-4003-ssv-6051-driver` | `(+48982/-0)[2M, 58A]` | a7dfad682db06b616163ae33c2df7820a92d4755 `ssv6200_aux.h`, `ssv6200_reg.h`, `dev.c`, `ampdu.c`, `ssv_cmd.c`, `ssv_rc.c`, `ssv_cfgvendor.c`, `init.c`, `sdio.c`, `ssv_hci.c`, `ap.c`, `ssv_ht_rc.c`, `ssv6200_common.h`, `dev.h`, `smartlink.c`, _and 43 more_ | `Paolo Sabatino` _add ssv6xxx wifi driver_ |


