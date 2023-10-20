#### kernel patching: 96 total patches; 96 applied; 0 with problems

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
|  🤖  ✅  | `[kernel-drivers/]` `sha1_58720809f52779dc0f08e53e54b014209d13eebb_rockchip64_edge_6f348e648f569189-01ba4719` | `(+0/-0)[]` | 9f2a19f72503293a25def3251f302f526953e75a `?` | `Armbian Autopatcher` _[AUTOGEN] /opt/build_armbian/extensions/cache/patch/kernel-drivers/sha1_58720809f52779dc0f08e53e54b014209d13eebb_rockchip64_edge_6f348e648f569189-01ba4719_ |
| ✅  | `add-board-helios64` | `(+764/-232)[1M]` | 02671e8f7c89e47c673d7ce8c170bd8d3c035de9 `rk3399-kobol-helios64.dts` | `Aditya Prayoga` _Add board Helios64_ |
| ✅  | `add-rockchip-iep-driver` | `(+1632/-1)[5M, 6A]` | 28e95ff3a7c468361cbdf4dc354622113a662b41 `iep.c`, `iep-regs.h`, `iep.h`, `rockchip-iep.yaml`, `rk3328.dtsi`, `rk3288.dtsi`, `rk3399.dtsi`, `Kconfig`, `Makefile` | `Paolo` _Rockchip IEP driver_ |
| ✅  | `board-helios64-dts-fix-stability-issues` | `(+1/-0)[1M]` | b535c18a7a6f79650c92ac6ef9ee0ff184cb9712 `rk3399-kobol-helios64.dts` | `Aditya Prayoga` _[ARCHEOLOGY] Attempt to improve stability on Helios64 (#2680)_ |
| ✅  | `board-helios64-remove-overclock` | `(+9/-1)[1M]` | 2cb646be5084bb8913b37812f246b4e08363c5ad `rk3399-kobol-helios64.dts` | `Aditya Prayoga` _Remove overclock from helios64_ |
| ✅  | `board-helios64-remove-pcie-ep-gpios` | `(+0/-1)[1M]` | ac3873b836368368f196921dd3d190728652334d `rk3399-kobol-helios64.dts` | `Aditya Prayoga` _Remove PCIE ep-gpios from Helios64_ |
| ✅  | `board-nanopc-t4-add-typec-dp` | `(+96/-0)[1M]` | 99d93fd8d20d6252e98f3cf3a6e468e6acfa5f86 `rk3399-nanopc-t4.dts` | `tonymac32` _Patching something_ |
| ✅  | `board-nanopi-m4v2-dts-add-sound-card` | `(+60/-0)[2M]` | ad931ee5d2d947cc7e6f01a4cd4eb057c643a15c `rk3399-nanopi4.dtsi`, `Kconfig` | `Piotr Szczepanik` _[ARCHEOLOGY] Initial addition of NanoPi M4V2_ |
| ✅  | `board-nanopi-r2c-plus` | `(+1/-1)[1M]` | 2bdd80c1576f454584d98c34d95c6a69e2642fa0 `rk3328-nanopi-r2c-plus.dts` | `amazingfate` _[ARCHEOLOGY] rockchip64: bump rockchip64-edge kernel to 6.5_ |
| ✅  | `board-nanopi-r2s` | `(+328/-165)[1M]` | f2acf1f8bfc977cea93d83cda948c4bef30c7f3d `rk3328-nanopi-r2s.dts` | `Paolo Sabatino` _rockchip64: consolidate nanopi r2s device trees_ |
| ✅  | `board-nanopi-r4s-pwmfan` | `(+35/-0)[1M]` | a11c12941259aaa1bfaa992612edd01d5565c9ea `rk3399-nanopi-r4s.dts` | `Bochun Bai` _Add pwm-fan support to nanopi r4s_ |
| ✅  | `board-orangepi-r1-plus` | `(+73/-36)[1M]` | b9de2a7a73a02de6eab6f7350fee9cad66cfc3fa `rk3328-orangepi-r1-plus.dts` | `Igor Pecovnik` _[ARCHEOLOGY] Initial ROCK Pi E support (as WIP) (#2042)_ |
| ✅  | `board-pbp-add-dp-alt-mode` | `(+210/-3)[4M]` | fdef09fb69027e56e7ed2acc89a816adf7fd19ee `tcpm.c`, `displayport.c`, `phy-rockchip-typec.c`, `rk3399-pinebook-pro.dts` | `Dan Johansen` _add-dp-alt-mode-to-PBP_ |
| ✅  | `board-radxa-e25-sdmmc0-fix` | `(+1/-1)[1M]` | 4158c8d914fb8f8275ea8682b0969ded0eec5eb3 `rk3568-radxa-e25.dts` | `krachlatte` _[ARCHEOLOGY] Improve SD card compatibility on Radxa E25 (#5165)_ |
| ✅  | `board-radxa-e25-usb3-and-emmc-fix` | `(+14/-0)[2M]` | 9947913b4b7027513bfed0e6c0baf411420bbc0c `rk3568-radxa-cm3i.dtsi`, `rk3568-radxa-e25.dts` | `krachlatte` _[ARCHEOLOGY] Improve SD card compatibility on Radxa E25 (#5165)_ |
| ✅  | `board-rk3328-roc-cc-dts-enable-dmc` | `(+38/-0)[1M]` | aafc96e4991438232e7005d36d6d806d383a0209 `rk3328-roc-cc.dts` | `Paolo Sabatino` _enable roc-cc dmc_ |
| ✅  | `board-rk3328-roc-cc-dts-ram-profile` | `(+311/-0)[1A]` | df73cc98afcff390f9b816cec3261a2ea94a1ec5 `rk3328-dram-renegade-timing.dtsi` | `tonymac32` _board-rk3328-roc-cc-adjust-DMC-opps_ |
| ✅  | `board-rk3328-roc-pc-dts-ram-profile` | `(+223/-0)[1A]` | a54f3da0a8e20924c5d415afeeb1d0b1a54c747a `rk3328-roc-pc-dram-timing.dtsi` | `Tony` _[ARCHEOLOGY] Add files via upload_ |
| ✅  | `board-rk3328-roc-pc` | `(+466/-59)[1M]` | 22574fb2cf25f317c579ee18b13b0cb9b0dafb75 `rk3328-roc-pc.dts` | `Paolo Sabatino` _enable dmc for rk3328-roc-pc_ |
| ✅  | `board-rock3a-emmc-sfc` | `(+11/-0)[1M]` | fd85b7fa68c54132a26b0147ee5faf2d57246de5 `rk3568-rock-3a.dts` | `Jianfeng Liu` _[ARCHEOLOGY] update rockchip64 edge to 5.19 (#4039)_ |
| ✅  | `board-rock3a-usb3` | `(+1/-0)[1M]` | e6bd14d47e9f0a1105aaa941d86e7793d0085e5b `rk3568-rock-3a.dts` | `Jianfeng Liu` _[ARCHEOLOGY] update rockchip64 edge to 5.19 (#4039)_ |
| ✅  | `board-rock64-mail-supply` | `(+5/-0)[1M]` | 4a0dfd4a41c50063e1877d1c33bfa21256189ed7 `rk3328-rock64.dts` | `tonymac32` _board_rock64_mali-usb-supply_ |
| ✅  | `board-rockpi3-enable-dmc` | `(+7/-0)[1M]` | c473fb9ea93eaa3bcf4244901135d447a46bca91 `rk3328-rock-pi-e.dts` | `Paolo Sabatino` _[ARCHEOLOGY] rockchip64: enable dmc on Rock PI E board_ |
| ✅  | `board-rockpi4-0003-arm64-dts-pcie` | `(+4/-0)[1M]` | e066d5a66761dd6007ffee8113119ec7e291eb1a `rk3399-rock-pi-4.dtsi` | `Piotr Szczepanik` _[ARCHEOLOGY] Rock Pi 4 enable PCIe in device tree for "dev" target (#1624)_ |
| ✅  | `board-rockpis-0001-arm64-dts` | `(+164/-76)[1M]` | 13cfabb926e4989bb9b83a4d8a1a6fcc0ba65feb `rk3308-rock-pi-s.dts` | `brentr` _[ARCHEOLOGY] Rockpis devtree mainlined (#4603)_ |
| ✅  | `board-rockpis-0005-arm64-dts-rk3308-Add-gmac-node-at-dtsi-level` | `(+1/-0)[1M]` | fccad1c7c9a6bf9f459edc30015ecbb422ffc72a `rk3308.dtsi` | `ashthespy` _arm64: dts: rk3308: Add mac node at dtsi level_ |
| ✅  | `board-rockpis-0007-arm64-dts-rockchip-add-cpu-s-thermal-config-for-rk33` | `(+64/-0)[1M]` | 7cc869c97dd6440dee002e998c04d171b72cb428 `rk3308.dtsi` | `ashthespy` _arm64: dts: rockchip: add cpu's thermal config for rk3308_ |
| ✅  | `board-rockpis-0008-thermal-rockchip-add-tsadc-support-for-rk3308` | `(+27/-0)[2M]` | 1471e5c60240133ca462ccc5e7d6e5538301290d `rockchip_thermal.c`, `rockchip-thermal.yaml` | `Rocky Hao` _thermal: rockchip: add tsadc support for rk3308_ |
| ✅  | `board-rockpis-0010-arm64-dts-rockchip-add-i2s_8ch-for-rk3308` | `(+103/-0)[1M]` | 343157015a258ab2d80655bccff5107e590c2290 `rk3308.dtsi` | `ashthespy` _arm64: dts: rockchip: add i2s_8ch for rk3308_ |
| ✅  | `board-rockpis-0012-arm64-dts-rk3308-Add-rk-timer-rtc` | `(+10/-1)[1M]` | 4697a294e1072b02488cbf892530e0495621bdd2 `rk3308.dtsi` | `ashthespy` _arm64: dts: rk3308: Add rk-timer-rtc_ |
| ✅  | `board-rockpis-0018-ASoC-codecs-Add-RK3308-internal-codec-driver` | `(+2571/-0)[2M, 2A]` | e2b025532042e5bc7320fa5743cc15b4562f61bb `rk3308_codec.c`, `rk3308_codec.h`, `Kconfig`, `Makefile` | `Xing Zheng` _ASoC: codecs: Add RK3308 internal codec driver_ |
| ✅  | `board-rockpis-0019-Sync-rk3308_codec-to-BSP-tree` | `(+4894/-1116)[2M, 2A]` | 8e4f1da79b39b361e272e1179d64ed1eb0b3dc25 `rk3308_codec.c`, `rk3308_codec.h`, `rockchip,rk3308-codec.txt`, `rk3308_codec_provider.h` | `ashthespy` _Sync `rk3308_codec` to BSP tree_ |
| ✅  | `board-rockpis-0020-arm64-dts-rockchip-Add-acodec-node-for-rk3308` | `(+17/-1)[1M]` | 8aebe6b6d066356aa1871be0624cbeafcd700c10 `rk3308.dtsi` | `ashthespy` _arm64: dts: rockchip: Add acodec node for rk3308_ |
| ✅  | `board-rockpis-0022-ASoC-rk3308_codec-replace-codec-to-component` | `(+84/-77)[2M]` | 3059bd03a22324497c1ca24ce4df4bf579d4d9d4 `rk3308_codec.c`, `rk3308_codec_provider.h` | `ashthespy` _ASoC: rk3308_codec: replace codec to component_ |
| ✅  | `board-rockpis-0027-arm64-dts-rk3308-add-otp-cpuinfo` | `(+29/-0)[1M]` | ef6824b18ea59fce6f7f2dcaab3e13ad0a436068 `rk3308.dtsi` | `Igor Pecovnik` _[ARCHEOLOGY] Bumping EDGE kernel to 5.14.y (#3125)_ |
| ✅  | `board-rockpis-0029-arm64-dts-rk3308-add-reserved-memory-ramoops` | `(+20/-0)[1M]` | 9889d2960dff3d526a92225d95c5aa43a71df285 `rk3308.dtsi` | `Igor Pecovnik` _[ARCHEOLOGY] Bumping EDGE kernel to 5.14.y (#3125)_ |
| ✅  | `board-rockpro64-0001-Add-pcie-bus-scan-delay` | `(+1/-0)[1M]` | a7a9d61000f69e88bec476fb28dbddc9782c578c `rk3399-rockpro64.dtsi` | `Piotr Szczepanik` _Rockpro64 add pcie bus scan delay_ |
| ✅  | `board-rockpro64-change-rx_delay-for-gmac` | `(+1/-1)[1M]` | 200cc886aa7874148ea894bd8c1d1a3da78252ea `rk3399-rockpro64.dtsi` | `Ayufan` _ayufan: dts: rockpro64: change rx_delay for gmac_ |
| ✅  | `board-rockpro64-fix-emmc` | `(+2/-0)[1M]` | c0a0706480388c7e8be6ac501df27326f7fbb276 `rk3399-rockpro64.dtsi` | `Martin Ayotte` _[ARCHEOLOGY] fix PMIC_INT_L gpio conflicting with I2C8_SCL in RockPro64_ |
| ✅  | `board-rockpro64-fix-spi1-flash-speed` | `(+1/-1)[1M]` | e4e29cd6fa3323a7a99efed1cb417d1a2ce6cc47 `rk3399-rockpro64.dtsi` | `Martin Ayotte` _[ARCHEOLOGY] slow SPIFlash to avoid errors_ |
| ✅  | `board-rockpro64-work-led-heartbeat` | `(+1/-1)[1M]` | ea64d864f65c093b035ea113144bdac976344037 `rk3399-rockpro64.dtsi` | `Piotr Szczepanik` _[ARCHEOLOGY] Switch RockPro64 work led to heartbeat trigger_ |
| ✅  | `board-tvbox-rk3318` | `(+311/-0)[1A]` | b97d4f1d5732b3efc1aed4f2285465558eb312f9 `rk3318-dram-default-timing.dtsi` | `Paolo` _[ARCHEOLOGY] rockchip64: add rk3318-box tvbox board patch and configurations (#3921)_ |
| ✅  | `drv-spi-spidev-remove-warnings` | `(+2/-0)[1M]` | e220432e21a8d74f3b6bb56973bdeeea43f7fc57 `spidev.c` | `The-going` _drv:spi:spidev remove warnings_ |
| ✅  | `general-add-miniDP-dt-doc` | `(+66/-0)[1A]` | 9962271b86605054966fb4be5c6bc5096dbc103d `extcon-usbc-virtual-pd.yaml` | `Tony` _[ARCHEOLOGY] RK3399 Typec DP (#2676)_ |
| ✅  | `general-add-miniDP-virtual-extcon` | `(+296/-0)[2M, 1A]` | 6cb9097c5cc5f2e927861d05151dc283abf4ee4d `extcon-usbc-virtual-pd.c`, `Kconfig`, `Makefile` | `Tony` _[ARCHEOLOGY] RK3399 Typec DP (#2676)_ |
| ✅  | `general-add-overlay-compilation-support` | `(+35/-1)[3M]` | 44db982dacc6266deb175017b4b88504746733df `Makefile.lib`, `Makefile.dtbinst`, `.gitignore` | `zador-blood-stained` _[ARCHEOLOGY] Rename, split and improve H3 DT overlays_ |
| ✅  | `general-add-overlay-configfs` | `(+320/-0)[2M, 2A]` | cfc169f582c90eaac8dd9888d73dc62bd3c1ed36 `configfs.c`, `configfs-overlays.txt`, `Kconfig`, `Makefile` | `Pantelis Antoniou` _OF: DT-Overlay configfs interface_ |
| ✅  | `general-add-panel-simple-dsi` | `(+773/-0)[1M, 1A]` | 8a3e04fedd351289ff6f5457dcc169fce8183c16 `panel-simple-dsi.c`, `Makefile` | `simple` _[ARCHEOLOGY] general add panel simple dsi (#3140)_ |
| ✅  | `general-add-pll-hdmi-timings` | `(+71/-0)[1M]` | f9addaba9bda83fb545283947be2d55e5dbf6039 `phy-rockchip-inno-hdmi.c` | `paolo` _[ARCHEOLOGY] Adding pll hdmi timing to rockchip64-dev too_ |
| ✅  | `general-add-xtx-spi-nor-chips` | `(+24/-0)[3M, 1A]` | d948d4539e91155809e3365942ca8bde1411f9a1 `xtx.c`, `Makefile`, `core.c`, `core.h` | `microcai` _spi-nor: Add support for xt25f32b/xt25f128b_ |
| ✅  | `general-disable-mtu-validation` | `(+0/-12)[1M]` | 2779b5016e98d9da44aaabf5ccc9d00d62ebf843 `stmmac_main.c` | `Igor Pecovnik` _Disable MTU validation_ |
| ✅  | `general-fix-es8316-kernel-panic` | `(+1/-1)[1M]` | a52d28df078ea74fcf6bac376f517165f27cd066 `es8316.c` | `Yannick Adam` _[ARCHEOLOGY] Enable es8316 on RockPi4 (#1885)_ |
| ✅  | `general-fix-inno-usb2-phy-init` | `(+0/-5)[1M]` | 02c7318ef7a152e0b9549308c3ade1d942c34900 `phy-rockchip-inno-usb2.c` | `Paolo Sabatino` _remove usb2phy extcon initialization causing kernel oops_ |
| ✅  | `general-fix-mmc-signal-voltage-before-reboot` | `(+8/-0)[1M]` | 9bdb3aa11d5508ef9df7b90eb8cf1205bbbdaf84 `core.c` | `Jonas Karlman` _mmc: core: set initial signal voltage on power off_ |
| ✅  | `general-increasing_DMA_block_memory_allocation_to_2048` | `(+3/-5)[1M]` | b0ffea068ce07df1d1a1da3c7b23c6fc7dc00def `pool.c` | `Igor Pecovnik` _[ARCHEOLOGY] Increasing DMA block memory allocation to 2048k on all relevant kernels._ |
| ✅  | `general-legacy-rockchip-hwrng` | `(+359/-0)[3M, 1A]` | fa96158a87802b36b8696d99ca189d1286714d8e `rockchip-rng.c`, `rk3308.dtsi`, `Kconfig`, `Makefile` | `brentr` _[ARCHEOLOGY] Restored Hardware Random Number Generator from legacy (4.4) kernel (#4286)_ |
| ✅  | `general-legacy-rockchip-hwrng_5.10` | `(+249/-79)[1M]` | 70a691004606097d6ec9d768d568247543354926 `rockchip-rng.c` | `brentr` _[ARCHEOLOGY] Updated v4.4 HW RND driver with that from v5.10 kernel (#4485)_ |
| ✅  | `general-possibility-of-disabling-rk808-rtc` | `(+2/-1)[2M]` | 0121030888312eb56970c70c00d8103914fc49cd `mfd-core.c`, `rk8xx-core.c` | `Piotr Szczepanik` _add possibility of disabling rk808-rtc_ |
| ✅  | `general-rk3328-dtsi-trb-ent-quirk` | `(+1/-0)[1M]` | 37a2632d46ba74ba654f55c2bc1e2b56d2b6fe50 `rk3328.dtsi` | `schwar3kat` _[ARCHEOLOGY] Enable rockchip64: XHCI HCD USB TRB ENT quirk for RK3328 (#3763)_ |
| ✅  | `general-rk808-configurable-switch-voltage-steps` | `(+13/-4)[1M]` | 232394ecf6a42781a6d821438e79dabbd61d82e7 `rk808-regulator.c` | `Piotr Szczepanik` _allows to change the way that BUCK1 and BUCK2 of rk808 PMIC_ |
| ✅  | `general-rockchip-overlays` | `(+3/-0)[1M]` | f48b5de0fb3b0e033d60c350de527990e57d5b30 `Makefile.lib` | `Martin Ayotte` _add overlays framework for rockchip (scripts/Makefile.lib only)_ |
| ✅  | `general-rt5651-add-mclk` | `(+17/-0)[2M]` | 2845ed784afd98c4e0d898fdc9c37a976d49acc1 `rt5651.c`, `rt5651.h` | `Piotr Szczepanik` _[ARCHEOLOGY] Fixed sound from rt5651 on OrangePi 4 (#1870)_ |
| ✅  | `general-workaround-broadcom-bt-serdev` | `(+1/-1)[1M]` | d5d5da8a0ba920ee9b55636a1db15f52a9f9da4c `btbcm.c` | `Paolo Sabatino` _Workaround to make several broadcom bluetooth serdev devices work even without proper MAC address_ |
| ✅  | `net-usb-r8152-add-LED-configuration-from-OF` | `(+23/-0)[1M]` | 7b3672adc9df4b9e32c9d8703a89e4f1021fe94d `r8152.c` | `David Bauer` _net: usb: r8152: add LED configuration from OF_ |
| ✅  | `regulator-add-fan53200-driver` | `(+533/-0)[3M, 1A]` | 6cabd6b47397182fb1bbdfde060a103eeecac843 `fan53200.c`, `Kconfig`, `defconfig`, `Makefile` | `Rock Shen` _regulator: add fan53200 regulator driver for Tinkerboard-2_ |
| ✅  | `rk3308-0001-pinctrl-slew-mux` | `(+100/-0)[4M]` | 17fab9cf1781f158ac9ea48cdb9e7fd841dff44d `pinctrl-rockchip.c`, `pinctrl-rockchip.h`, `pinconf-generic.c`, `pinconf-generic.h` | `brentr` _[ARCHEOLOGY] Rockpis wifi fixes (#4008)_ |
| ✅  | `rk3308-0002-iodomains` | `(+45/-0)[1M]` | dc97c12b1a610286b799e67c8705af7a4cb60c2b `io-domain.c` | `brentr` _[ARCHEOLOGY] Rockpis wifi fixes (#4008)_ |
| ✅  | `rk3308-0003-pinctrl-io-voltage-domains` | `(+24/-45)[2M]` | 84fc046d36221ecaa6eb72560aa21679d2487eb5 `io-domain.c`, `pinctrl-rockchip.c` | `brentr` _[ARCHEOLOGY] Rockpis wifi fixes (#4008)_ |
| ✅  | `rk3328-add-dmc-driver` | `(+2099/-56)[8M, 4A]` | 95ea8a3877c962119c1a8ea676f885485116d273 `rk3328_dmc.c`, `rockchip-dfi.c`, `rk3328-dram-default-timing.dtsi`, `rk3328-dram.h`, `clk-ddr.c`, `rockchip-ddr.h`, `rk3328.dtsi`, `clk-rk3328.c`, `Kconfig`, `rockchip_sip.h`, `clk.h`, `Makefile` | `Paolo Sabatino` _rk3328 dmc driver_ |
| ✅  | `rk3328-add-rga-node` | `(+14/-0)[1M]` | bcb5185750a969e86162bfc3d88e09bae62d3b39 `rk3328.dtsi` | `Paolo Sabatino` _rk3328: add RGA node_ |
| ✅  | `rk3328-dtsi-mali-opp-table` | `(+25/-0)[1M]` | 47d5c0e8be31d4945e7d4b53f2d25927e4e86a75 `rk3328.dtsi` | `Paolo Sabatino` _gpu operating points_ |
| ✅  | `rk3328-dtsi-mmc-reset-properties` | `(+6/-0)[1M]` | daac70a662a99d07dda9e3bfbb749c9751a00b71 `rk3328.dtsi` | `Paolo Sabatino` _mmc reset properties_ |
| ✅  | `rk3328-dtsi-sdmmc-ext-node` | `(+14/-0)[1M]` | 5a87fe12056e529b79e6ec5913cc05b886fcaff0 `rk3328.dtsi` | `Paolo Sabatino` _sdmmc-ext node_ |
| ✅  | `rk3328-dtsi-spdif` | `(+27/-0)[1M]` | ec90d624aea082e607f912b1b49c0bc780dc3664 `rk3328.dtsi` | `Paolo Sabatino` _[ARCHEOLOGY] rockchip64: tidy up rk3328 patches_ |
| ✅  | `rk3328-dtsi-usb3-reset-properties` | `(+2/-0)[1M]` | 1498672f6e74aeb064c4b197b91390250ddcfe5f `rk3328.dtsi` | `Paolo Sabatino` _usb3 reset properties_ |
| ✅  | `rk3328-gpu-cooling-target` | `(+6/-0)[1M]` | 526712ec01bf7841c45d54c66878c5d2f3caabe2 `rk3328.dtsi` | `tonymac32` _rk3328-gpu-cooling-target_ |
| ✅  | `rk3328-roc-cc-add-missing-nodes` | `(+32/-0)[1M]` | 534fd7518a6e6ae98b1662aa510a8e9ba4c98895 `rk3328-roc-cc.dts` | `tonymac32` _rk3328-roc-cc add missing nodes_ |
| ✅  | `rk3399-add-sclk-i2sout-src-clock` | `(+2/-1)[2M]` | 16ceb6097c8dcb48de51636c88ab773b12cf0b29 `clk-rk3399.c`, `rk3399-cru.h` | `Piotr Szczepanik` _[ARCHEOLOGY] Fixed sound from rt5651 on OrangePi 4 (#1870)_ |
| ✅  | `rk3399-dmc-polling-rate` | `(+1/-1)[1M]` | 71ee2c22dbd4867203d41d1e52d7ad4bce8680b2 `rk3399_dmc.c` | `Paolo Sabatino` _[ARCHEOLOGY] rockchip64: set poll rate 50ms for rk3399 dmc driver_ |
| ✅  | `rk3399-enable-dwc3-xhci-usb-trb-quirk` | `(+2/-0)[1M]` | e8132cb2888df72fe0ae5a89e74330d28f5e74c1 `rk3399.dtsi` | `Aditya Prayoga` _[ARCHEOLOGY] Fix 2.5G Ethernet on Helios64 Mainline kernel (#2567)_ |
| ✅  | `rk3399-fix-usb-phy` | `(+1/-1)[1M]` | 4faa29f6630e3c529bb6bc9877edbcd715dd7fbd `phy-rockchip-typec.c` | `Paolo Sabatino` _increase timeout for usb3 type C phy init_ |
| ✅  | `rk3399-rp64-pcie-Reimplement-rockchip-PCIe-bus-scan-delay` | `(+41/-0)[4M]` | ec48b149ceca16a73518fc01435ba54021d56fe6 `pcie-rockchip-host.c`, `kernel-parameters.txt`, `pcie-rockchip.c`, `pcie-rockchip.h` | `Dan Pasanen` _[ARCHEOLOGY] rockchip-[current,edge]: add pcie hack and lsi scsi/sas support (#3351)_ |
| ✅  | `rk3399-rp64-rng` | `(+10/-0)[1M]` | bebde00362e02f474da5a81e7612cd9fb99ba2d8 `rk3399.dtsi` | `Igor Pecovnik` _RK3399 Add rng bits_ |
| ✅  | `rk3399-sd-drive-level-8ma` | `(+8/-8)[1M]` | 54918dc49bb297c865442b398591f840b4f3f726 `rk3399.dtsi` | `Martin Ayotte` _[ARCHEOLOGY] add better strength on SDCard and put back previous speed setting_ |
| ✅  | `rk3399-sd-pwr-pinctrl` | `(+5/-0)[1M]` | c14b94cbb676dc663481462af0e8140e186ee705 `rk3399.dtsi` | `Paolo Sabatino` _rk3399: add sd power pin to pinctrl node_ |
| ✅  | `rk3399-unlock-temperature` | `(+3/-3)[1M]` | a024aad8f314cd2537f457e8d6fbdebf238a4085 `rk3399.dtsi` | `ThomasKaiser` _[ARCHEOLOGY] Increase performance with rk3399-dev_ |
| ✅  | `rk356x-vop2-support` | `(+68/-79)[1M]` | 1ba1fcc866dbb0324cb1980a84eb336c0a0acd19 `dw_hdmi-rockchip.c` | `Miouyouyou` _[ARCHEOLOGY] [RFC] RK3288 : Add HDMI resolutions (#1887)_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+77/-0)[1A]` | 16a9e5178beb73a74276fe67d1b823af1e61db88 `rockchip,rk3588-crypto.yaml` | `Corentin Labbe` _dt-bindings: crypto: add support for rockchip,crypto-rk3588_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+12/-0)[1M]` | d13c80b0159f0cf1e7dd3da80529a95c47c61532 `rk3588s.dtsi` | `Corentin Labbe` _ARM64: dts: rk3588: add crypto node_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+12/-0)[1M]` | 42e8248df98b092fada5107cde72d6fdb065ae5d `rk356x.dtsi` | `Corentin Labbe` _ARM64: dts: rk356x: add crypto node_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+34/-76)[2M]` | c10883cda1b8dfc1a080743023882e3b8f4f52f3 `rockchip,rk3588-cru.h`, `rst-rk3588.c` | `Corentin Labbe` _reset: rockchip: secure reset must be used by SCMI_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+1944/-0)[2M, 4A]` | d9a130b029527e28e1fe301c1d1ca67ebd7f097d `rk3588_crypto.c`, `rk3588_crypto_skcipher.c`, `rk3588_crypto_ahash.c`, `rk3588_crypto.h`, `Kconfig`, `Makefile` | `Corentin Labbe` _crypto: rockchip: add rk3588 driver_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+1/-1)[1M]` | 0edb419eb79685c6c0dde641927b00384f2bd8a0 `Kconfig` | `Corentin Labbe` _SM3 fix_ |
| ✅  | `wifi-4003-add-bcm43342-chip` | `(+3/-0)[2M]` | dd863418728a5abd777dbb28332ace4ad192dca0 `sdio.c`, `brcm_hw_ids.h` | `Paolo Sabatino` _add broadcom bcm43342 chip id_ |
| ✅  | `wifi-4003-ssv-6051-driver` | `(+48981/-0)[2M, 58A]` | dbbff3dac3bfd2bbf21e87ba42bdadf3bbe90b4e `ssv6200_aux.h`, `ssv6200_reg.h`, `dev.c`, `ampdu.c`, `ssv_cmd.c`, `ssv_rc.c`, `ssv_cfgvendor.c`, `init.c`, `sdio.c`, `ssv_hci.c`, `ap.c`, `ssv_ht_rc.c`, `ssv6200_common.h`, `dev.h`, `smartlink.c`, _and 43 more_ | `Paolo Sabatino` _add ssv6xxx wifi driver_ |
| ✅  | `wifi-4003-uwe5622-adjust-for-rockchip` | `(+3472/-597)[36M, 4A]` | 7d120d08c8775189fb7c44ab22cc63a7f6f979c1 `wcn_bind_helper.c`, `rfkill-wlan.c`, `rfkill-bt.c`, `cmdevt.c`, `wl_intf.c`, `wl_core.c`, `cfg80211.c`, `qos.c`, `txrx.c`, `intf_ops.h`, `wcn_wrapper.h`, `intf.h`, `sdiohal_main.c`, `npi.c`, `wcn_misc.c`, _and 23 more_ | `Paolo Sabatino` _adjust uwe5622 driver for rockchip_ |


