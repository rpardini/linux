#### kernel patching: 99 total patches; 99 applied; 0 with problems

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
|  🤖  ✅  | `[kernel-drivers/]` `sha1_8a749fd1a8720d4619c91c8b6e7528c0a355c0aa_rockchip64_edge_e9fbeeea0af99dbf-01ba4719` | `(+0/-0)[]` | 231663ecd622a975052e9b96d0c39950d35381b6 `?` | `Armbian Autopatcher` _[AUTOGEN] /armbian/cache/patch/kernel-drivers/sha1_8a749fd1a8720d4619c91c8b6e7528c0a355c0aa_rockchip64_edge_e9fbeeea0af99dbf-01ba4719_ |
| ✅  | `add-board-helios64` | `(+764/-232)[1M]` | 4c56f5dd805bc9ab4ca02c327d4b22626f8a370d `rk3399-kobol-helios64.dts` | `Aditya Prayoga` _Add board Helios64_ |
| ✅  | `add-maker-friendlyarm` | `(+157/-0)[2M, 3A]` | 0be29e21502c2e15a91ce050898a3da7d42e7f9f `board.c`, `Kconfig`, `Makefile` | `hmz007` _soc: friendlyelec: Add board info driver_ |
| ✅  | `add-rockchip-iep-driver` | `(+1632/-1)[5M, 6A]` | 06709ee3a9686015d83522f07a034914e15bc425 `iep.c`, `iep-regs.h`, `iep.h`, `rockchip-iep.yaml`, `rk3328.dtsi`, `rk3288.dtsi`, `rk3399.dtsi`, `Kconfig`, `Makefile` | `Paolo` _Rockchip IEP driver_ |
| ✅  | `board-helios64-dts-fix-stability-issues` | `(+1/-0)[1M]` | e39034e361d20ca1eb2bd818f3e9f8290ee663df `rk3399-kobol-helios64.dts` | `Aditya Prayoga` _[ARCHEOLOGY] Attempt to improve stability on Helios64 (#2680)_ |
| ✅  | `board-helios64-remove-overclock` | `(+9/-1)[1M]` | e38de3dbd349170700897d7e0f8c0c1b1ed65741 `rk3399-kobol-helios64.dts` | `Aditya Prayoga` _Remove overclock from helios64_ |
| ✅  | `board-helios64-remove-pcie-ep-gpios` | `(+0/-1)[1M]` | 2e8cee0ec9cf5b1efe4a22c0a7ad7bd848f53290 `rk3399-kobol-helios64.dts` | `Aditya Prayoga` _Remove PCIE ep-gpios from Helios64_ |
| ✅  | `board-nanopc-t4-add-typec-dp` | `(+96/-0)[1M]` | 99bee8981c457b7743e9c412d31e14af59d02daf `rk3399-nanopc-t4.dts` | `tonymac32` _Patching something_ |
| ✅  | `board-nanopi-m4v2-dts-add-sound-card` | `(+60/-0)[2M]` | d0b23d8b1f1e79e581c18cd4edd0f91690f682ea `rk3399-nanopi4.dtsi`, `Kconfig` | `Piotr Szczepanik` _[ARCHEOLOGY] Initial addition of NanoPi M4V2_ |
| ✅  | `board-nanopi-r2c-plus` | `(+1/-1)[1M]` | ecc4ef9dccd2a5763ee5f65387f50227210f97cd `rk3328-nanopi-r2c-plus.dts` | `amazingfate` _[ARCHEOLOGY] rockchip64: bump rockchip64-edge kernel to 6.5_ |
| ✅  | `board-nanopi-r2s` | `(+328/-165)[1M]` | a91ded8961c1e73eb33b89f9fca8686321f2b947 `rk3328-nanopi-r2s.dts` | `Paolo Sabatino` _rockchip64: consolidate nanopi r2s device trees_ |
| ✅  | `board-nanopi-r4s-pwmfan` | `(+35/-0)[1M]` | 07e93b8fb37a34788647dec21054d1256c941f0c `rk3399-nanopi-r4s.dts` | `Bochun Bai` _Add pwm-fan support to nanopi r4s_ |
| ✅  | `board-orangepi-r1-plus` | `(+73/-36)[1M]` | 8d1a5e8d18e6422b30237dc04533331b6c6ee985 `rk3328-orangepi-r1-plus.dts` | `Igor Pecovnik` _[ARCHEOLOGY] Initial ROCK Pi E support (as WIP) (#2042)_ |
| ✅  | `board-pbp-add-dp-alt-mode` | `(+210/-3)[4M]` | 708197a4399791390511d1819abddf24711f76fc `tcpm.c`, `displayport.c`, `phy-rockchip-typec.c`, `rk3399-pinebook-pro.dts` | `Dan Johansen` _add-dp-alt-mode-to-PBP_ |
| ✅  | `board-radxa-e25-sdmmc0-fix` | `(+1/-1)[1M]` | f85e02092cb34dee030c9e7528c4c2415094a5b4 `rk3568-radxa-e25.dts` | `krachlatte` _[ARCHEOLOGY] Improve SD card compatibility on Radxa E25 (#5165)_ |
| ✅  | `board-radxa-e25-usb3-and-emmc-fix` | `(+14/-0)[2M]` | c67d116cf313f1fe0f72611c4d5c6d987bb6ae9b `rk3568-radxa-cm3i.dtsi`, `rk3568-radxa-e25.dts` | `krachlatte` _[ARCHEOLOGY] Improve SD card compatibility on Radxa E25 (#5165)_ |
| ✅  | `board-rk3328-roc-cc-dts-enable-dmc` | `(+38/-0)[1M]` | 8a8aaf508422f9ded2af92f42754cf8be9b8530a `rk3328-roc-cc.dts` | `Paolo Sabatino` _enable roc-cc dmc_ |
| ✅  | `board-rk3328-roc-cc-dts-ram-profile` | `(+311/-0)[1A]` | c7887f8d774acb3e27b63b438b6b1dacc24f5912 `rk3328-dram-renegade-timing.dtsi` | `tonymac32` _board-rk3328-roc-cc-adjust-DMC-opps_ |
| ✅  | `board-rk3328-roc-pc-dts-ram-profile` | `(+223/-0)[1A]` | f295210ded5715651048d8990c989a28c41071c4 `rk3328-roc-pc-dram-timing.dtsi` | `Tony` _[ARCHEOLOGY] Add files via upload_ |
| ✅  | `board-rk3328-roc-pc` | `(+466/-59)[1M]` | b027b7d602b1cc4d824012b4c412a9a828bed5af `rk3328-roc-pc.dts` | `Paolo Sabatino` _enable dmc for rk3328-roc-pc_ |
| ✅  | `board-rock3a-emmc-sfc` | `(+11/-0)[1M]` | e54584275145ab36b029b0c18fac370b13896fde `rk3568-rock-3a.dts` | `Jianfeng Liu` _[ARCHEOLOGY] update rockchip64 edge to 5.19 (#4039)_ |
| ✅  | `board-rock3a-usb3` | `(+1/-0)[1M]` | 4c8c1576c703d8a93239c1a648a8b134982529b8 `rk3568-rock-3a.dts` | `Jianfeng Liu` _[ARCHEOLOGY] update rockchip64 edge to 5.19 (#4039)_ |
| ✅  | `board-rock64-mail-supply` | `(+5/-0)[1M]` | 5353a1faadf98dde63671b12b47979fb37f9ef56 `rk3328-rock64.dts` | `tonymac32` _board_rock64_mali-usb-supply_ |
| ✅  | `board-rockpi3-enable-dmc` | `(+7/-0)[1M]` | 7b012b08425e52c2f2f55655977813781f9cc5fb `rk3328-rock-pi-e.dts` | `Paolo Sabatino` _[ARCHEOLOGY] rockchip64: enable dmc on Rock PI E board_ |
| ✅  | `board-rockpi4-0003-arm64-dts-pcie` | `(+4/-0)[1M]` | 7c7af35b3ca33be0158b3e657dae10a9dc889b6d `rk3399-rock-pi-4.dtsi` | `Piotr Szczepanik` _[ARCHEOLOGY] Rock Pi 4 enable PCIe in device tree for "dev" target (#1624)_ |
| ✅  | `board-rockpis-0001-arm64-dts` | `(+164/-76)[1M]` | 9b6657108c28528bc6ad2fe361d46a69fc845bac `rk3308-rock-pi-s.dts` | `brentr` _[ARCHEOLOGY] Rockpis devtree mainlined (#4603)_ |
| ✅  | `board-rockpis-0005-arm64-dts-rk3308-Add-gmac-node-at-dtsi-level` | `(+1/-0)[1M]` | 9dcfc47fd7e460f93bc95f9d377c8b66b68bf0fa `rk3308.dtsi` | `ashthespy` _arm64: dts: rk3308: Add mac node at dtsi level_ |
| ✅  | `board-rockpis-0007-arm64-dts-rockchip-add-cpu-s-thermal-config-for-rk33` | `(+64/-0)[1M]` | 7e4165ea2d11f067c6acafb184c4f1c37c3dcfe4 `rk3308.dtsi` | `ashthespy` _arm64: dts: rockchip: add cpu's thermal config for rk3308_ |
| ✅  | `board-rockpis-0008-thermal-rockchip-add-tsadc-support-for-rk3308` | `(+27/-0)[2M]` | 0c382218e17fd529d8dc35d56e8f5ace6fe3d17f `rockchip_thermal.c`, `rockchip-thermal.yaml` | `Rocky Hao` _thermal: rockchip: add tsadc support for rk3308_ |
| ✅  | `board-rockpis-0010-arm64-dts-rockchip-add-i2s_8ch-for-rk3308` | `(+103/-0)[1M]` | e36ca59b68dd39bb719ffb2ae29cc88563b2fb6d `rk3308.dtsi` | `ashthespy` _arm64: dts: rockchip: add i2s_8ch for rk3308_ |
| ✅  | `board-rockpis-0012-arm64-dts-rk3308-Add-rk-timer-rtc` | `(+10/-1)[1M]` | cf15163d0e59824212bb2d7bbcd737b0aab18cc4 `rk3308.dtsi` | `ashthespy` _arm64: dts: rk3308: Add rk-timer-rtc_ |
| ✅  | `board-rockpis-0018-ASoC-codecs-Add-RK3308-internal-codec-driver` | `(+2571/-0)[2M, 2A]` | 1981e134be5a718284e7a3dbd4ed6fed7195694e `rk3308_codec.c`, `rk3308_codec.h`, `Kconfig`, `Makefile` | `Xing Zheng` _ASoC: codecs: Add RK3308 internal codec driver_ |
| ✅  | `board-rockpis-0019-Sync-rk3308_codec-to-BSP-tree` | `(+4894/-1116)[2M, 2A]` | 8a79b7fcb8ddbb0f88ebe98cd2e81544261f0ca4 `rk3308_codec.c`, `rk3308_codec.h`, `rockchip,rk3308-codec.txt`, `rk3308_codec_provider.h` | `ashthespy` _Sync `rk3308_codec` to BSP tree_ |
| ✅  | `board-rockpis-0020-arm64-dts-rockchip-Add-acodec-node-for-rk3308` | `(+17/-1)[1M]` | a065d9c587dd8056b22ab96b6e185bbb2806dcec `rk3308.dtsi` | `ashthespy` _arm64: dts: rockchip: Add acodec node for rk3308_ |
| ✅  | `board-rockpis-0022-ASoC-rk3308_codec-replace-codec-to-component` | `(+84/-77)[2M]` | 1417febaf4ff514a9f280cd9b13f1157f6333103 `rk3308_codec.c`, `rk3308_codec_provider.h` | `ashthespy` _ASoC: rk3308_codec: replace codec to component_ |
| ✅  | `board-rockpis-0027-arm64-dts-rk3308-add-otp-cpuinfo` | `(+29/-0)[1M]` | 03475878b9dc93a0df711502e99d69c1438c7c7a `rk3308.dtsi` | `Igor Pecovnik` _[ARCHEOLOGY] Bumping EDGE kernel to 5.14.y (#3125)_ |
| ✅  | `board-rockpis-0029-arm64-dts-rk3308-add-reserved-memory-ramoops` | `(+20/-0)[1M]` | 96717485167da82229b5550e362293c00b53b955 `rk3308.dtsi` | `Igor Pecovnik` _[ARCHEOLOGY] Bumping EDGE kernel to 5.14.y (#3125)_ |
| ✅  | `board-rockpro64-0001-Add-pcie-bus-scan-delay` | `(+1/-0)[1M]` | 804c1e3d3091b484e15ab299606ed3fee44868f3 `rk3399-rockpro64.dtsi` | `Piotr Szczepanik` _Rockpro64 add pcie bus scan delay_ |
| ✅  | `board-rockpro64-change-rx_delay-for-gmac` | `(+1/-1)[1M]` | e36b5698233c6e85775ab6f9a0ede48e2dc6668d `rk3399-rockpro64.dtsi` | `Ayufan` _ayufan: dts: rockpro64: change rx_delay for gmac_ |
| ✅  | `board-rockpro64-fix-emmc` | `(+2/-0)[1M]` | b638842d3e920888aaa6964889ffc9f6c900b1c5 `rk3399-rockpro64.dtsi` | `Martin Ayotte` _[ARCHEOLOGY] fix PMIC_INT_L gpio conflicting with I2C8_SCL in RockPro64_ |
| ✅  | `board-rockpro64-fix-spi1-flash-speed` | `(+1/-1)[1M]` | a57917424e329ee463551a3d33512e9374ff1184 `rk3399-rockpro64.dtsi` | `Martin Ayotte` _[ARCHEOLOGY] slow SPIFlash to avoid errors_ |
| ✅  | `board-rockpro64-work-led-heartbeat` | `(+1/-1)[1M]` | de44016c6700972e77894281855948a8204c52f3 `rk3399-rockpro64.dtsi` | `Piotr Szczepanik` _[ARCHEOLOGY] Switch RockPro64 work led to heartbeat trigger_ |
| ✅  | `board-tvbox-rk3318` | `(+311/-0)[1A]` | 0c919cedfbed3045f9caab5148bc0c487f2e748d `rk3318-dram-default-timing.dtsi` | `Paolo` _[ARCHEOLOGY] rockchip64: add rk3318-box tvbox board patch and configurations (#3921)_ |
| ✅  | `drv-spi-spidev-remove-warnings` | `(+2/-0)[1M]` | f2aa326dc24d58196428ba82a06086464c2489c5 `spidev.c` | `The-going` _drv:spi:spidev remove warnings_ |
| ✅  | `general-add-miniDP-dt-doc` | `(+66/-0)[1A]` | 16765cc91634a6839f470dd409b03c6c6a57b108 `extcon-usbc-virtual-pd.yaml` | `Tony` _[ARCHEOLOGY] RK3399 Typec DP (#2676)_ |
| ✅  | `general-add-miniDP-virtual-extcon` | `(+296/-0)[2M, 1A]` | 3febdad3f8156ca1f1f3ed23f719b0d3dce3e6e0 `extcon-usbc-virtual-pd.c`, `Kconfig`, `Makefile` | `Tony` _[ARCHEOLOGY] RK3399 Typec DP (#2676)_ |
| ✅  | `general-add-overlay-compilation-support` | `(+35/-1)[3M]` | 1cadc4a96ab30035809b3942ba273c03123aba2c `Makefile.lib`, `Makefile.dtbinst`, `.gitignore` | `zador-blood-stained` _[ARCHEOLOGY] Rename, split and improve H3 DT overlays_ |
| ✅  | `general-add-overlay-configfs` | `(+329/-0)[2M, 2A]` | ec000cc41efcf9b3170eeeb1954a2f9edb817b96 `configfs.c`, `configfs-overlays.txt`, `Kconfig`, `Makefile` | `schwar3kat` _OF: DT-Overlay configfs interface_ |
| ✅  | `general-add-panel-simple-dsi` | `(+773/-0)[1M, 1A]` | 4ad94ee6d996542c128790e6ed37aa7f4956882b `panel-simple-dsi.c`, `Makefile` | `simple` _[ARCHEOLOGY] general add panel simple dsi (#3140)_ |
| ✅  | `general-add-pll-hdmi-timings` | `(+71/-0)[1M]` | a4c078c056a5457a348cf7dbfbb72ee7033a794f `phy-rockchip-inno-hdmi.c` | `paolo` _[ARCHEOLOGY] Adding pll hdmi timing to rockchip64-dev too_ |
| ✅  | `general-add-xtx-spi-nor-chips` | `(+24/-0)[3M, 1A]` | 997a19749274ef55fe3a893bc5e18b8e70850c7a `xtx.c`, `Makefile`, `core.c`, `core.h` | `microcai` _spi-nor: Add support for xt25f32b/xt25f128b_ |
| ✅  | `general-disable-mtu-validation` | `(+0/-12)[1M]` | 6be46643d917753083d1fac4218771f7f1f6b8c1 `stmmac_main.c` | `Igor Pecovnik` _Disable MTU validation_ |
| ✅  | `general-fix-es8316-kernel-panic` | `(+1/-1)[1M]` | 9ae24fb6f38dbe9f7ed5dacb0f33d62f19488b1b `es8316.c` | `Yannick Adam` _[ARCHEOLOGY] Enable es8316 on RockPi4 (#1885)_ |
| ✅  | `general-fix-inno-usb2-phy-init` | `(+0/-5)[1M]` | 1f62b563e9892ccd0947eb2fa0c3b236fee3cc05 `phy-rockchip-inno-usb2.c` | `Paolo Sabatino` _remove usb2phy extcon initialization causing kernel oops_ |
| ✅  | `general-fix-mmc-signal-voltage-before-reboot` | `(+8/-0)[1M]` | 39a6b2e0614548af8a6eadab14d833c7d6438fe1 `core.c` | `Jonas Karlman` _mmc: core: set initial signal voltage on power off_ |
| ✅  | `general-increasing_DMA_block_memory_allocation_to_2048` | `(+3/-5)[1M]` | 332a07d539e67b8a463823d17c54dbbd0b50c00b `pool.c` | `Igor Pecovnik` _[ARCHEOLOGY] Increasing DMA block memory allocation to 2048k on all relevant kernels._ |
| ✅  | `general-legacy-rockchip-hwrng` | `(+359/-0)[3M, 1A]` | e1ba2bd115fa91d70b976340eb6ea316350fa571 `rockchip-rng.c`, `rk3308.dtsi`, `Kconfig`, `Makefile` | `brentr` _[ARCHEOLOGY] Restored Hardware Random Number Generator from legacy (4.4) kernel (#4286)_ |
| ✅  | `general-legacy-rockchip-hwrng_5.10` | `(+249/-79)[1M]` | d66f62db2f75d83b59b160589832ba30dabcc252 `rockchip-rng.c` | `brentr` _[ARCHEOLOGY] Updated v4.4 HW RND driver with that from v5.10 kernel (#4485)_ |
| ✅  | `general-possibility-of-disabling-rk808-rtc` | `(+2/-1)[2M]` | a5615bb99b60abc01e17c982f77eeed9702823c1 `mfd-core.c`, `rk8xx-core.c` | `Piotr Szczepanik` _add possibility of disabling rk808-rtc_ |
| ✅  | `general-rk3328-dtsi-trb-ent-quirk` | `(+1/-0)[1M]` | 0b007084b40a33eabef55abac4d2cd8d3861bb72 `rk3328.dtsi` | `schwar3kat` _[ARCHEOLOGY] Enable rockchip64: XHCI HCD USB TRB ENT quirk for RK3328 (#3763)_ |
| ✅  | `general-rk808-configurable-switch-voltage-steps` | `(+13/-4)[1M]` | 0a6b71e3e1ad2a978471e49671c83b9d389e9c98 `rk808-regulator.c` | `Piotr Szczepanik` _allows to change the way that BUCK1 and BUCK2 of rk808 PMIC_ |
| ✅  | `general-rockchip-overlays` | `(+3/-0)[1M]` | a46322b7f1e25d119bfbc746889e326b09343ac7 `Makefile.lib` | `Martin Ayotte` _add overlays framework for rockchip (scripts/Makefile.lib only)_ |
| ✅  | `general-rt5651-add-mclk` | `(+17/-0)[2M]` | 49abbda26526eb0351612817891de9371c548a85 `rt5651.c`, `rt5651.h` | `Piotr Szczepanik` _[ARCHEOLOGY] Fixed sound from rt5651 on OrangePi 4 (#1870)_ |
| ✅  | `general-workaround-broadcom-bt-serdev` | `(+1/-1)[1M]` | f3385b0fe8cbe9761517e7c16f47d6b9aec1e0f4 `btbcm.c` | `Paolo Sabatino` _Workaround to make several broadcom bluetooth serdev devices work even without proper MAC address_ |
| ✅  | `net-usb-r8152-add-LED-configuration-from-OF` | `(+23/-0)[1M]` | af816900c3bde17402c7aa7cb5ffa8025b4b62bc `r8152.c` | `David Bauer` _net: usb: r8152: add LED configuration from OF_ |
| ✅  | `regulator-add-fan53200-driver` | `(+533/-0)[3M, 1A]` | 2395eac619c8fa14ba1942d3d5a7bd19f622d743 `fan53200.c`, `Kconfig`, `defconfig`, `Makefile` | `Rock Shen` _regulator: add fan53200 regulator driver for Tinkerboard-2_ |
| ✅  | `rk3308-0001-pinctrl-slew-mux` | `(+100/-0)[4M]` | 40a8939e1f624e3df52d17f7f4e96bb830e5be12 `pinctrl-rockchip.c`, `pinctrl-rockchip.h`, `pinconf-generic.c`, `pinconf-generic.h` | `brentr` _[ARCHEOLOGY] Rockpis wifi fixes (#4008)_ |
| ✅  | `rk3308-0002-iodomains` | `(+45/-0)[1M]` | a8fa6c088c1ad795a045d4cefc412c4516e8ef07 `io-domain.c` | `brentr` _[ARCHEOLOGY] Rockpis wifi fixes (#4008)_ |
| ✅  | `rk3308-0003-pinctrl-io-voltage-domains` | `(+24/-45)[2M]` | 27dd6bb7505e29c58d15dbdc9490cba2b16e2bbf `io-domain.c`, `pinctrl-rockchip.c` | `brentr` _[ARCHEOLOGY] Rockpis wifi fixes (#4008)_ |
| ✅  | `rk3328-add-dmc-driver` | `(+2099/-56)[8M, 4A]` | 5976b376e9c8e36d5bebda0406a947881ca0e75e `rk3328_dmc.c`, `rockchip-dfi.c`, `rk3328-dram-default-timing.dtsi`, `rk3328-dram.h`, `clk-ddr.c`, `rockchip-ddr.h`, `rk3328.dtsi`, `clk-rk3328.c`, `Kconfig`, `rockchip_sip.h`, `clk.h`, `Makefile` | `Paolo Sabatino` _rk3328 dmc driver_ |
| ✅  | `rk3328-add-rga-node` | `(+14/-0)[1M]` | 94cedd14300b4369993f7b990bd2f333ff8a720c `rk3328.dtsi` | `Paolo Sabatino` _rk3328: add RGA node_ |
| ✅  | `rk3328-dtsi-mali-opp-table` | `(+25/-0)[1M]` | f514e042e115ad68a69b0adf01de271492ef3770 `rk3328.dtsi` | `Paolo Sabatino` _gpu operating points_ |
| ✅  | `rk3328-dtsi-mmc-reset-properties` | `(+6/-0)[1M]` | d05a49610c96c62881b83705ff7caa2505235cc6 `rk3328.dtsi` | `Paolo Sabatino` _mmc reset properties_ |
| ✅  | `rk3328-dtsi-sdmmc-ext-node` | `(+14/-0)[1M]` | a1b798b7f1fec6ffd9f1677b654513efd425bd42 `rk3328.dtsi` | `Paolo Sabatino` _sdmmc-ext node_ |
| ✅  | `rk3328-dtsi-spdif` | `(+27/-0)[1M]` | bce84c56b985dbaf5fb8d65dd50c1f20de430a8e `rk3328.dtsi` | `Paolo Sabatino` _[ARCHEOLOGY] rockchip64: tidy up rk3328 patches_ |
| ✅  | `rk3328-dtsi-usb3-reset-properties` | `(+2/-0)[1M]` | 5ca0e25e78f5ae037ee4721db3ba5de9469a0dfa `rk3328.dtsi` | `Paolo Sabatino` _usb3 reset properties_ |
| ✅  | `rk3328-gpu-cooling-target` | `(+6/-0)[1M]` | e430bc0ce44fd8f9d79b9938387ded040f3a3906 `rk3328.dtsi` | `tonymac32` _rk3328-gpu-cooling-target_ |
| ✅  | `rk3328-roc-cc-add-missing-nodes` | `(+32/-0)[1M]` | e0784c192e156556f7262e1f17abc6923f0072f6 `rk3328-roc-cc.dts` | `tonymac32` _rk3328-roc-cc add missing nodes_ |
| ✅  | `rk3399-add-sclk-i2sout-src-clock` | `(+2/-1)[2M]` | e52d015a610c5a3ecd7744afeddb66de7b2f20ee `clk-rk3399.c`, `rk3399-cru.h` | `Piotr Szczepanik` _[ARCHEOLOGY] Fixed sound from rt5651 on OrangePi 4 (#1870)_ |
| ✅  | `rk3399-dmc-polling-rate` | `(+1/-1)[1M]` | a8202c875978961bb36584c4588bfbb23cf7cfbe `rk3399_dmc.c` | `Paolo Sabatino` _[ARCHEOLOGY] rockchip64: set poll rate 50ms for rk3399 dmc driver_ |
| ✅  | `rk3399-enable-dwc3-xhci-usb-trb-quirk` | `(+2/-0)[1M]` | 9779fb4bb1fe1a793f9872afb14043f9c1b0f5ee `rk3399.dtsi` | `Aditya Prayoga` _[ARCHEOLOGY] Fix 2.5G Ethernet on Helios64 Mainline kernel (#2567)_ |
| ✅  | `rk3399-fix-usb-phy` | `(+1/-1)[1M]` | e0d30388e0ce2dc0d1429621e6e4a9d42c4e1c65 `phy-rockchip-typec.c` | `Paolo Sabatino` _increase timeout for usb3 type C phy init_ |
| ✅  | `rk3399-rp64-pcie-Reimplement-rockchip-PCIe-bus-scan-delay` | `(+41/-0)[4M]` | 99ae63c5b42d92128db11ffe7752bf5b49413ce3 `pcie-rockchip-host.c`, `kernel-parameters.txt`, `pcie-rockchip.c`, `pcie-rockchip.h` | `Dan Pasanen` _[ARCHEOLOGY] rockchip-[current,edge]: add pcie hack and lsi scsi/sas support (#3351)_ |
| ✅  | `rk3399-rp64-rng` | `(+10/-0)[1M]` | a8fe12806f35bb382ff1e0c11a84e04e8895ffe9 `rk3399.dtsi` | `Igor Pecovnik` _RK3399 Add rng bits_ |
| ✅  | `rk3399-sd-drive-level-8ma` | `(+8/-8)[1M]` | 5e5a7e86ec74f925a4180deac93aba2a2805fc21 `rk3399.dtsi` | `Martin Ayotte` _[ARCHEOLOGY] add better strength on SDCard and put back previous speed setting_ |
| ✅  | `rk3399-sd-pwr-pinctrl` | `(+5/-0)[1M]` | 49eeec0c025afe6707f4ae42bb61b9f2e774f7f6 `rk3399.dtsi` | `Paolo Sabatino` _rk3399: add sd power pin to pinctrl node_ |
| ✅  | `rk3399-unlock-temperature` | `(+3/-3)[1M]` | 9b8e1d8f078864c790e8aa4818d2f5b7c3ce0023 `rk3399.dtsi` | `ThomasKaiser` _[ARCHEOLOGY] Increase performance with rk3399-dev_ |
| ✅  | `rk356x-vop2-support` | `(+68/-79)[1M]` | 1bb13adca320d90e0c94d1f41085e702cd9b29f0 `dw_hdmi-rockchip.c` | `Miouyouyou` _[ARCHEOLOGY] [RFC] RK3288 : Add HDMI resolutions (#1887)_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+61/-0)[1A]` | 59174c96ca438a0d873888858e54610b1733f1db `rockchip,rk3588-crypto.yaml` | `Corentin Labbe` _dt-bindings: crypto: add support for rockchip,crypto-rk3588_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+11/-0)[1M]` | d2863b6efec7c0334185d174fc456670b3ff6ff9 `rk3588s.dtsi` | `Corentin Labbe` _ARM64: dts: rk3588: add crypto node_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+13/-0)[1M]` | a8e4a44d22d4ff63bdbca7b715d2d528bdccbb85 `rk3568.dtsi` | `Corentin Labbe` _ARM64: dts: rk3568: add crypto node_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+34/-76)[2M]` | 9ac8692a2fa6c85ce8d8a1b517ba2b69e304303a `rockchip,rk3588-cru.h`, `rst-rk3588.c` | `Corentin Labbe` _reset: rockchip: secure reset must be used by SCMI_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+1936/-0)[2M, 4A]` | 2a8b5db68364f3cc176896bc5880e58cfedff37c `rk3588_crypto.c`, `rk3588_crypto_skcipher.c`, `rk3588_crypto_ahash.c`, `rk3588_crypto.h`, `Kconfig`, `Makefile` | `Corentin Labbe` _crypto: rockchip: add rk3588 driver_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+7/-0)[1M]` | 693572c5928a29b302bf4b6aab382c1a85e4bb33 `rk3588_crypto.c` | `Corentin Labbe` _crypto: rockchip: add support for rk3568_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+16/-0)[1M]` | 7da3f23d96f3819897197113c53d59cca8d61319 `rockchip,rk3588-crypto.yaml` | `Corentin Labbe` _dt-bindings: crypto: add support for rockchip,crypto-rk3568_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+13/-0)[1M]` | 1eb0782a79aac6a7f6e8c6bb9ff022a2d79996f5 `rk356x.dtsi` | `Corentin Labbe` _arm64: dts: rk3566 TODO_ |
| ✅  | `wifi-4003-add-bcm43342-chip` | `(+3/-0)[2M]` | e2c40bf4a382227cc8e35587ea03fc562949a042 `sdio.c`, `brcm_hw_ids.h` | `Paolo Sabatino` _add broadcom bcm43342 chip id_ |
| ✅  | `wifi-4003-ssv-6051-driver` | `(+48981/-0)[2M, 58A]` | c7e1a76efeb01780419f78e814868a62adb48df0 `ssv6200_aux.h`, `ssv6200_reg.h`, `dev.c`, `ampdu.c`, `ssv_cmd.c`, `ssv_rc.c`, `ssv_cfgvendor.c`, `init.c`, `sdio.c`, `ssv_hci.c`, `ap.c`, `ssv_ht_rc.c`, `ssv6200_common.h`, `dev.h`, `smartlink.c`, _and 43 more_ | `Paolo Sabatino` _add ssv6xxx wifi driver_ |
| ✅  | `wifi-4003-uwe5622-adjust-for-rockchip` | `(+3472/-597)[36M, 4A]` | 554ec0d9277ca10952c00a1259beb79648129ed6 `wcn_bind_helper.c`, `rfkill-wlan.c`, `rfkill-bt.c`, `cmdevt.c`, `wl_intf.c`, `wl_core.c`, `cfg80211.c`, `qos.c`, `txrx.c`, `intf_ops.h`, `wcn_wrapper.h`, `intf.h`, `sdiohal_main.c`, `npi.c`, `wcn_misc.c`, _and 23 more_ | `Paolo Sabatino` _adjust uwe5622 driver for rockchip_ |


