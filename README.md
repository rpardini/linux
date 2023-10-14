#### kernel patching: 96 total patches; 96 applied; 0 with problems

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
|  🤖  ✅  | `[kernel-drivers/]` `sha1_94f6f0550c625fab1f373bb86a6669b45e9748b3_rockchip64_edge_0efe0f3da4f762d0-01ba4719` | `(+0/-0)[]` | 62febc6da2c8c17c416fa11a389016195950770c `?` | `Armbian Autopatcher` _[AUTOGEN] /armbian/cache/patch/kernel-drivers/sha1_94f6f0550c625fab1f373bb86a6669b45e9748b3_rockchip64_edge_0efe0f3da4f762d0-01ba4719_ |
| ✅  | `add-board-helios64` | `(+764/-232)[1M]` | 554f136ee4acb6f8be6099c97197de6a5d278539 `rk3399-kobol-helios64.dts` | `Aditya Prayoga` _Add board Helios64_ |
| ✅  | `add-rockchip-iep-driver` | `(+1632/-1)[5M, 6A]` | cf1f806c3eebe1219081c86060ff563e61e03e48 `iep.c`, `iep-regs.h`, `iep.h`, `rockchip-iep.yaml`, `rk3328.dtsi`, `rk3288.dtsi`, `rk3399.dtsi`, `Kconfig`, `Makefile` | `Paolo` _Rockchip IEP driver_ |
| ✅  | `board-helios64-dts-fix-stability-issues` | `(+1/-0)[1M]` | 009262fd0da61771c86b47ddaf9d3a9cc41c725d `rk3399-kobol-helios64.dts` | `Aditya Prayoga` _[ARCHEOLOGY] Attempt to improve stability on Helios64 (#2680)_ |
| ✅  | `board-helios64-remove-overclock` | `(+9/-1)[1M]` | 89f410d3de67bcac84e13353974b9f2ad93f1246 `rk3399-kobol-helios64.dts` | `Aditya Prayoga` _Remove overclock from helios64_ |
| ✅  | `board-helios64-remove-pcie-ep-gpios` | `(+0/-1)[1M]` | a612ea10b89c87b2225eaa38081281a54dfce581 `rk3399-kobol-helios64.dts` | `Aditya Prayoga` _Remove PCIE ep-gpios from Helios64_ |
| ✅  | `board-nanopc-t4-add-typec-dp` | `(+96/-0)[1M]` | 08a921202049cc692b84978fcd0d4110dfac0ed6 `rk3399-nanopc-t4.dts` | `tonymac32` _Patching something_ |
| ✅  | `board-nanopi-m4v2-dts-add-sound-card` | `(+60/-0)[2M]` | 2797496015e924cc27fbb828845250364baa6dcf `rk3399-nanopi4.dtsi`, `Kconfig` | `Piotr Szczepanik` _[ARCHEOLOGY] Initial addition of NanoPi M4V2_ |
| ✅  | `board-nanopi-r2c-plus` | `(+1/-1)[1M]` | d7039b634c0b482082ca864f3de70738abd4d0f6 `rk3328-nanopi-r2c-plus.dts` | `amazingfate` _[ARCHEOLOGY] rockchip64: bump rockchip64-edge kernel to 6.5_ |
| ✅  | `board-nanopi-r2s` | `(+328/-165)[1M]` | 29e47d76c21ae218d3a4d35240853ea8b6116978 `rk3328-nanopi-r2s.dts` | `Paolo Sabatino` _rockchip64: consolidate nanopi r2s device trees_ |
| ✅  | `board-nanopi-r4s-pwmfan` | `(+35/-0)[1M]` | 791187d3c39963c8d883096eee6463c9a097cd70 `rk3399-nanopi-r4s.dts` | `Bochun Bai` _Add pwm-fan support to nanopi r4s_ |
| ✅  | `board-orangepi-r1-plus` | `(+73/-36)[1M]` | 85c42516a84223d33934f6b416b58bf45fcf2a27 `rk3328-orangepi-r1-plus.dts` | `Igor Pecovnik` _[ARCHEOLOGY] Initial ROCK Pi E support (as WIP) (#2042)_ |
| ✅  | `board-pbp-add-dp-alt-mode` | `(+210/-3)[4M]` | 12d9d6c9d0b191b531590e73dacd2bd1ff1f5e38 `tcpm.c`, `displayport.c`, `phy-rockchip-typec.c`, `rk3399-pinebook-pro.dts` | `Dan Johansen` _add-dp-alt-mode-to-PBP_ |
| ✅  | `board-radxa-e25-sdmmc0-fix` | `(+1/-1)[1M]` | b5d2004248c83ff52e21f5f2415cc1de1b40b065 `rk3568-radxa-e25.dts` | `krachlatte` _[ARCHEOLOGY] Improve SD card compatibility on Radxa E25 (#5165)_ |
| ✅  | `board-radxa-e25-usb3-and-emmc-fix` | `(+14/-0)[2M]` | a7bb54afda50579816781bacd72c2a2b8b7fece7 `rk3568-radxa-cm3i.dtsi`, `rk3568-radxa-e25.dts` | `krachlatte` _[ARCHEOLOGY] Improve SD card compatibility on Radxa E25 (#5165)_ |
| ✅  | `board-rk3328-roc-cc-dts-enable-dmc` | `(+38/-0)[1M]` | 95f275497491f39d4d9ecda3755e4a92f9b284f7 `rk3328-roc-cc.dts` | `Paolo Sabatino` _enable roc-cc dmc_ |
| ✅  | `board-rk3328-roc-cc-dts-ram-profile` | `(+311/-0)[1A]` | f54bc68c6b0d8c1853082dd4211e4828fc7c1534 `rk3328-dram-renegade-timing.dtsi` | `tonymac32` _board-rk3328-roc-cc-adjust-DMC-opps_ |
| ✅  | `board-rk3328-roc-pc-dts-ram-profile` | `(+223/-0)[1A]` | a65017312cd122e741ad36e59dff084cedb3b2bc `rk3328-roc-pc-dram-timing.dtsi` | `Tony` _[ARCHEOLOGY] Add files via upload_ |
| ✅  | `board-rk3328-roc-pc` | `(+466/-59)[1M]` | 3e74efd229351127ad9427fdfa2940173fb6e34d `rk3328-roc-pc.dts` | `Paolo Sabatino` _enable dmc for rk3328-roc-pc_ |
| ✅  | `board-rock3a-emmc-sfc` | `(+11/-0)[1M]` | d3dab2377dc4ce7954eb959ab51b86d63511d4c7 `rk3568-rock-3a.dts` | `Jianfeng Liu` _[ARCHEOLOGY] update rockchip64 edge to 5.19 (#4039)_ |
| ✅  | `board-rock3a-usb3` | `(+1/-0)[1M]` | 4767daaf0d59c9ab3ef9bd249fc7960e2bd82fe6 `rk3568-rock-3a.dts` | `Jianfeng Liu` _[ARCHEOLOGY] update rockchip64 edge to 5.19 (#4039)_ |
| ✅  | `board-rock64-mail-supply` | `(+5/-0)[1M]` | f3c141e5f506393eb312881c3882587ae5a99a95 `rk3328-rock64.dts` | `tonymac32` _board_rock64_mali-usb-supply_ |
| ✅  | `board-rockpi3-enable-dmc` | `(+7/-0)[1M]` | 6e88c712439b04c17959d2ab6c3a9f504261b739 `rk3328-rock-pi-e.dts` | `Paolo Sabatino` _[ARCHEOLOGY] rockchip64: enable dmc on Rock PI E board_ |
| ✅  | `board-rockpi4-0003-arm64-dts-pcie` | `(+4/-0)[1M]` | e5e8817bff9b2973586a8a6c275268bacb48f32d `rk3399-rock-pi-4.dtsi` | `Piotr Szczepanik` _[ARCHEOLOGY] Rock Pi 4 enable PCIe in device tree for "dev" target (#1624)_ |
| ✅  | `board-rockpis-0001-arm64-dts` | `(+164/-76)[1M]` | 808b5a3183ca71de4d7e7b014fa728c4d820df09 `rk3308-rock-pi-s.dts` | `brentr` _[ARCHEOLOGY] Rockpis devtree mainlined (#4603)_ |
| ✅  | `board-rockpis-0005-arm64-dts-rk3308-Add-gmac-node-at-dtsi-level` | `(+1/-0)[1M]` | 7a18e8d69e931f822211b171d43d149b1c0bcfd2 `rk3308.dtsi` | `ashthespy` _arm64: dts: rk3308: Add mac node at dtsi level_ |
| ✅  | `board-rockpis-0007-arm64-dts-rockchip-add-cpu-s-thermal-config-for-rk33` | `(+64/-0)[1M]` | 8c734b116d6c154894cf79ed419c2ff6724b9995 `rk3308.dtsi` | `ashthespy` _arm64: dts: rockchip: add cpu's thermal config for rk3308_ |
| ✅  | `board-rockpis-0008-thermal-rockchip-add-tsadc-support-for-rk3308` | `(+27/-0)[2M]` | bd50fc04a00c96b39a5ac3d24448a53da66a5ba9 `rockchip_thermal.c`, `rockchip-thermal.yaml` | `Rocky Hao` _thermal: rockchip: add tsadc support for rk3308_ |
| ✅  | `board-rockpis-0010-arm64-dts-rockchip-add-i2s_8ch-for-rk3308` | `(+103/-0)[1M]` | d043c6afd4427cbd7f6b24ab49f7bd8e0996ff9d `rk3308.dtsi` | `ashthespy` _arm64: dts: rockchip: add i2s_8ch for rk3308_ |
| ✅  | `board-rockpis-0012-arm64-dts-rk3308-Add-rk-timer-rtc` | `(+10/-1)[1M]` | 34d35fcd4bb20741c86977ee35e5110015d6eb99 `rk3308.dtsi` | `ashthespy` _arm64: dts: rk3308: Add rk-timer-rtc_ |
| ✅  | `board-rockpis-0018-ASoC-codecs-Add-RK3308-internal-codec-driver` | `(+2571/-0)[2M, 2A]` | 2a1141f540543f9f6616ca3ac3c686ab7689f174 `rk3308_codec.c`, `rk3308_codec.h`, `Kconfig`, `Makefile` | `Xing Zheng` _ASoC: codecs: Add RK3308 internal codec driver_ |
| ✅  | `board-rockpis-0019-Sync-rk3308_codec-to-BSP-tree` | `(+4894/-1116)[2M, 2A]` | f91a5dbafe3bd74b2842e71e97042a1e52a11727 `rk3308_codec.c`, `rk3308_codec.h`, `rockchip,rk3308-codec.txt`, `rk3308_codec_provider.h` | `ashthespy` _Sync `rk3308_codec` to BSP tree_ |
| ✅  | `board-rockpis-0020-arm64-dts-rockchip-Add-acodec-node-for-rk3308` | `(+17/-1)[1M]` | d0bd5b2a7f8d9bd1aab18cbfcd387836cd6bd75c `rk3308.dtsi` | `ashthespy` _arm64: dts: rockchip: Add acodec node for rk3308_ |
| ✅  | `board-rockpis-0022-ASoC-rk3308_codec-replace-codec-to-component` | `(+84/-77)[2M]` | ac989d04ab66a862c1e388f7cd5aecfce4033ad6 `rk3308_codec.c`, `rk3308_codec_provider.h` | `ashthespy` _ASoC: rk3308_codec: replace codec to component_ |
| ✅  | `board-rockpis-0027-arm64-dts-rk3308-add-otp-cpuinfo` | `(+29/-0)[1M]` | 06547d8c3705f082f007d254c38164772d9653e4 `rk3308.dtsi` | `Igor Pecovnik` _[ARCHEOLOGY] Bumping EDGE kernel to 5.14.y (#3125)_ |
| ✅  | `board-rockpis-0029-arm64-dts-rk3308-add-reserved-memory-ramoops` | `(+20/-0)[1M]` | 1d98d41b8486d8de52f965038a4b0e8063595727 `rk3308.dtsi` | `Igor Pecovnik` _[ARCHEOLOGY] Bumping EDGE kernel to 5.14.y (#3125)_ |
| ✅  | `board-rockpro64-0001-Add-pcie-bus-scan-delay` | `(+1/-0)[1M]` | ce2e58d2f2f7e5ad2ad6dd1e8b0a9f028a3b7c69 `rk3399-rockpro64.dtsi` | `Piotr Szczepanik` _Rockpro64 add pcie bus scan delay_ |
| ✅  | `board-rockpro64-change-rx_delay-for-gmac` | `(+1/-1)[1M]` | d8bc2c742d20b5073f48227c2c912d102cf8a2bf `rk3399-rockpro64.dtsi` | `Ayufan` _ayufan: dts: rockpro64: change rx_delay for gmac_ |
| ✅  | `board-rockpro64-fix-emmc` | `(+2/-0)[1M]` | 9cad6af74e95b5995380118a3a20f36165eb3452 `rk3399-rockpro64.dtsi` | `Martin Ayotte` _[ARCHEOLOGY] fix PMIC_INT_L gpio conflicting with I2C8_SCL in RockPro64_ |
| ✅  | `board-rockpro64-fix-spi1-flash-speed` | `(+1/-1)[1M]` | 19cd82b4f674ad0b51931472954651b316e5d997 `rk3399-rockpro64.dtsi` | `Martin Ayotte` _[ARCHEOLOGY] slow SPIFlash to avoid errors_ |
| ✅  | `board-rockpro64-work-led-heartbeat` | `(+1/-1)[1M]` | dd2ed291a36efb4ee72f81f6043a5a655de9aee9 `rk3399-rockpro64.dtsi` | `Piotr Szczepanik` _[ARCHEOLOGY] Switch RockPro64 work led to heartbeat trigger_ |
| ✅  | `board-tvbox-rk3318` | `(+311/-0)[1A]` | f11f2e1d2976fa9b4e9c8d54efbb4eb589a433ae `rk3318-dram-default-timing.dtsi` | `Paolo` _[ARCHEOLOGY] rockchip64: add rk3318-box tvbox board patch and configurations (#3921)_ |
| ✅  | `drv-spi-spidev-remove-warnings` | `(+2/-0)[1M]` | b636f63e1f6f1815708aadc8e81a819dc1cfb647 `spidev.c` | `The-going` _drv:spi:spidev remove warnings_ |
| ✅  | `general-add-miniDP-dt-doc` | `(+66/-0)[1A]` | de050e45a3560a8bf2df16700fa50c36c599bcb7 `extcon-usbc-virtual-pd.yaml` | `Tony` _[ARCHEOLOGY] RK3399 Typec DP (#2676)_ |
| ✅  | `general-add-miniDP-virtual-extcon` | `(+296/-0)[2M, 1A]` | 981c9af72ae3835bf0d89d697ea9201bb5e48574 `extcon-usbc-virtual-pd.c`, `Kconfig`, `Makefile` | `Tony` _[ARCHEOLOGY] RK3399 Typec DP (#2676)_ |
| ✅  | `general-add-overlay-compilation-support` | `(+35/-1)[3M]` | 3796c64c887837bc648d4f50ec83c0d3c3667fb9 `Makefile.lib`, `Makefile.dtbinst`, `.gitignore` | `zador-blood-stained` _[ARCHEOLOGY] Rename, split and improve H3 DT overlays_ |
| ✅  | `general-add-overlay-configfs` | `(+320/-0)[2M, 2A]` | 822e5282c58f14c67e109e36991e4ceb4bb41655 `configfs.c`, `configfs-overlays.txt`, `Kconfig`, `Makefile` | `Pantelis Antoniou` _OF: DT-Overlay configfs interface_ |
| ✅  | `general-add-panel-simple-dsi` | `(+773/-0)[1M, 1A]` | 86a1e3293a5d6e174b82a22b57236f48384f1b71 `panel-simple-dsi.c`, `Makefile` | `simple` _[ARCHEOLOGY] general add panel simple dsi (#3140)_ |
| ✅  | `general-add-pll-hdmi-timings` | `(+71/-0)[1M]` | 278365610bc9a7c04574b73abb263b2f6c1351d2 `phy-rockchip-inno-hdmi.c` | `paolo` _[ARCHEOLOGY] Adding pll hdmi timing to rockchip64-dev too_ |
| ✅  | `general-add-xtx-spi-nor-chips` | `(+24/-0)[3M, 1A]` | 2ff8f92d8f83b656f8e635dbef06663f1c931d58 `xtx.c`, `Makefile`, `core.c`, `core.h` | `microcai` _spi-nor: Add support for xt25f32b/xt25f128b_ |
| ✅  | `general-disable-mtu-validation` | `(+0/-12)[1M]` | 3896bae5a52c502d374524db4af29927411dae59 `stmmac_main.c` | `Igor Pecovnik` _Disable MTU validation_ |
| ✅  | `general-fix-es8316-kernel-panic` | `(+1/-1)[1M]` | 2434c73f90bb8119862a95701757cbf384e0c7b0 `es8316.c` | `Yannick Adam` _[ARCHEOLOGY] Enable es8316 on RockPi4 (#1885)_ |
| ✅  | `general-fix-inno-usb2-phy-init` | `(+0/-5)[1M]` | 0a5025248db1b04f1baf0529297aa7b09a29ff4a `phy-rockchip-inno-usb2.c` | `Paolo Sabatino` _remove usb2phy extcon initialization causing kernel oops_ |
| ✅  | `general-fix-mmc-signal-voltage-before-reboot` | `(+8/-0)[1M]` | 5e38da22a51014afc79becc69588d5a700f9035f `core.c` | `Jonas Karlman` _mmc: core: set initial signal voltage on power off_ |
| ✅  | `general-increasing_DMA_block_memory_allocation_to_2048` | `(+3/-5)[1M]` | c831c9f8b4eadf4e389fdef7c826f884d5801b6e `pool.c` | `Igor Pecovnik` _[ARCHEOLOGY] Increasing DMA block memory allocation to 2048k on all relevant kernels._ |
| ✅  | `general-legacy-rockchip-hwrng` | `(+359/-0)[3M, 1A]` | 9d685f3cb1a242bde91aa0fd3e4481ba4d698c60 `rockchip-rng.c`, `rk3308.dtsi`, `Kconfig`, `Makefile` | `brentr` _[ARCHEOLOGY] Restored Hardware Random Number Generator from legacy (4.4) kernel (#4286)_ |
| ✅  | `general-legacy-rockchip-hwrng_5.10` | `(+249/-79)[1M]` | 0e900bb5bbbf023ba95268accef362c6ebbf0499 `rockchip-rng.c` | `brentr` _[ARCHEOLOGY] Updated v4.4 HW RND driver with that from v5.10 kernel (#4485)_ |
| ✅  | `general-possibility-of-disabling-rk808-rtc` | `(+2/-1)[2M]` | f532ad97af7174e9c7f693df269f27688d2cc823 `mfd-core.c`, `rk8xx-core.c` | `Piotr Szczepanik` _add possibility of disabling rk808-rtc_ |
| ✅  | `general-rk3328-dtsi-trb-ent-quirk` | `(+1/-0)[1M]` | c2468738d1d4aed0c45e31b74ab8c7df035d1d13 `rk3328.dtsi` | `schwar3kat` _[ARCHEOLOGY] Enable rockchip64: XHCI HCD USB TRB ENT quirk for RK3328 (#3763)_ |
| ✅  | `general-rk808-configurable-switch-voltage-steps` | `(+13/-4)[1M]` | bad1869df7922b357c42ebf34afd4e5232d4963f `rk808-regulator.c` | `Piotr Szczepanik` _allows to change the way that BUCK1 and BUCK2 of rk808 PMIC_ |
| ✅  | `general-rockchip-overlays` | `(+3/-0)[1M]` | 34d183f5f8d316dc0d4ab4bef56e0e73f0bfd4b7 `Makefile.lib` | `Martin Ayotte` _add overlays framework for rockchip (scripts/Makefile.lib only)_ |
| ✅  | `general-rt5651-add-mclk` | `(+17/-0)[2M]` | 79e46bfce1a2f93973f8b2b640d3f55bbfd32fd5 `rt5651.c`, `rt5651.h` | `Piotr Szczepanik` _[ARCHEOLOGY] Fixed sound from rt5651 on OrangePi 4 (#1870)_ |
| ✅  | `general-workaround-broadcom-bt-serdev` | `(+1/-1)[1M]` | f91998720369b0ef6725ed44f4fc0a3731afdf2a `btbcm.c` | `Paolo Sabatino` _Workaround to make several broadcom bluetooth serdev devices work even without proper MAC address_ |
| ✅  | `net-usb-r8152-add-LED-configuration-from-OF` | `(+23/-0)[1M]` | 98f363b3069224c0c15632fbb0b812df3b5c5eda `r8152.c` | `David Bauer` _net: usb: r8152: add LED configuration from OF_ |
| ✅  | `regulator-add-fan53200-driver` | `(+533/-0)[3M, 1A]` | cecaea62d95cf002c8cee0c142b9fd99a777720b `fan53200.c`, `Kconfig`, `defconfig`, `Makefile` | `Rock Shen` _regulator: add fan53200 regulator driver for Tinkerboard-2_ |
| ✅  | `rk3308-0001-pinctrl-slew-mux` | `(+100/-0)[4M]` | b5d6bc0978b9bace83b05aea90b3f36708eccdf6 `pinctrl-rockchip.c`, `pinctrl-rockchip.h`, `pinconf-generic.c`, `pinconf-generic.h` | `brentr` _[ARCHEOLOGY] Rockpis wifi fixes (#4008)_ |
| ✅  | `rk3308-0002-iodomains` | `(+45/-0)[1M]` | 2874773c1d29c58f2aaacf4b154fffa149610ffe `io-domain.c` | `brentr` _[ARCHEOLOGY] Rockpis wifi fixes (#4008)_ |
| ✅  | `rk3308-0003-pinctrl-io-voltage-domains` | `(+24/-45)[2M]` | 24985624096c2ee378d04b6698ceda82aaf8ff2d `io-domain.c`, `pinctrl-rockchip.c` | `brentr` _[ARCHEOLOGY] Rockpis wifi fixes (#4008)_ |
| ✅  | `rk3328-add-dmc-driver` | `(+2099/-56)[8M, 4A]` | c0d91d61c38267f7a4fde4a391329339bd0bec47 `rk3328_dmc.c`, `rockchip-dfi.c`, `rk3328-dram-default-timing.dtsi`, `rk3328-dram.h`, `clk-ddr.c`, `rockchip-ddr.h`, `rk3328.dtsi`, `clk-rk3328.c`, `Kconfig`, `rockchip_sip.h`, `clk.h`, `Makefile` | `Paolo Sabatino` _rk3328 dmc driver_ |
| ✅  | `rk3328-add-rga-node` | `(+14/-0)[1M]` | 22bc60198a30e00232f2a6827c7c4fe359b2482b `rk3328.dtsi` | `Paolo Sabatino` _rk3328: add RGA node_ |
| ✅  | `rk3328-dtsi-mali-opp-table` | `(+25/-0)[1M]` | 5bb316c36ce2c222882ed3b5cd7f3fa8d1196341 `rk3328.dtsi` | `Paolo Sabatino` _gpu operating points_ |
| ✅  | `rk3328-dtsi-mmc-reset-properties` | `(+6/-0)[1M]` | 7453bbbe875cffe52c00789980996a139fda6ca2 `rk3328.dtsi` | `Paolo Sabatino` _mmc reset properties_ |
| ✅  | `rk3328-dtsi-sdmmc-ext-node` | `(+14/-0)[1M]` | 43f0fd30ddb44504b5e75d5ffbdbc6bf6d96f23c `rk3328.dtsi` | `Paolo Sabatino` _sdmmc-ext node_ |
| ✅  | `rk3328-dtsi-spdif` | `(+27/-0)[1M]` | cd06da2b44185d764450ba96664859aee32dfb60 `rk3328.dtsi` | `Paolo Sabatino` _[ARCHEOLOGY] rockchip64: tidy up rk3328 patches_ |
| ✅  | `rk3328-dtsi-usb3-reset-properties` | `(+2/-0)[1M]` | 049c47b2ef241f4ec27f84a17f1a83276dd7980b `rk3328.dtsi` | `Paolo Sabatino` _usb3 reset properties_ |
| ✅  | `rk3328-gpu-cooling-target` | `(+6/-0)[1M]` | 2ad10a4073946bdfcf35451f2f770ba6faad2dea `rk3328.dtsi` | `tonymac32` _rk3328-gpu-cooling-target_ |
| ✅  | `rk3328-roc-cc-add-missing-nodes` | `(+32/-0)[1M]` | c9dd668cf2b39263b2f56a6f8d51dc29457e5c70 `rk3328-roc-cc.dts` | `tonymac32` _rk3328-roc-cc add missing nodes_ |
| ✅  | `rk3399-add-sclk-i2sout-src-clock` | `(+2/-1)[2M]` | 030523a4cc398b7dd7cd35feeda6f1ab6abcd7a8 `clk-rk3399.c`, `rk3399-cru.h` | `Piotr Szczepanik` _[ARCHEOLOGY] Fixed sound from rt5651 on OrangePi 4 (#1870)_ |
| ✅  | `rk3399-dmc-polling-rate` | `(+1/-1)[1M]` | fa8b99754091fe0b663d911982e2b461e103df1b `rk3399_dmc.c` | `Paolo Sabatino` _[ARCHEOLOGY] rockchip64: set poll rate 50ms for rk3399 dmc driver_ |
| ✅  | `rk3399-enable-dwc3-xhci-usb-trb-quirk` | `(+2/-0)[1M]` | 622db670b78ed22081bf48f6c080dd0018e24cfd `rk3399.dtsi` | `Aditya Prayoga` _[ARCHEOLOGY] Fix 2.5G Ethernet on Helios64 Mainline kernel (#2567)_ |
| ✅  | `rk3399-fix-usb-phy` | `(+1/-1)[1M]` | 92f2441dd561f81c65abcc6c7d2dec39936101cd `phy-rockchip-typec.c` | `Paolo Sabatino` _increase timeout for usb3 type C phy init_ |
| ✅  | `rk3399-rp64-pcie-Reimplement-rockchip-PCIe-bus-scan-delay` | `(+41/-0)[4M]` | c91e72695de24a356f653c7bb5ef751b3b04661c `pcie-rockchip-host.c`, `kernel-parameters.txt`, `pcie-rockchip.c`, `pcie-rockchip.h` | `Dan Pasanen` _[ARCHEOLOGY] rockchip-[current,edge]: add pcie hack and lsi scsi/sas support (#3351)_ |
| ✅  | `rk3399-rp64-rng` | `(+10/-0)[1M]` | 986d162671ac98c4ffda159c5528ff01ae8ddd12 `rk3399.dtsi` | `Igor Pecovnik` _RK3399 Add rng bits_ |
| ✅  | `rk3399-sd-drive-level-8ma` | `(+8/-8)[1M]` | 7b8ae63216183912d144ef21c2e2671c8424d3e0 `rk3399.dtsi` | `Martin Ayotte` _[ARCHEOLOGY] add better strength on SDCard and put back previous speed setting_ |
| ✅  | `rk3399-sd-pwr-pinctrl` | `(+5/-0)[1M]` | 47d06ca7fe833a198189ab5fffb3da2f962fc915 `rk3399.dtsi` | `Paolo Sabatino` _rk3399: add sd power pin to pinctrl node_ |
| ✅  | `rk3399-unlock-temperature` | `(+3/-3)[1M]` | efd14daf61c6a5b2483be06389b044076221ddf0 `rk3399.dtsi` | `ThomasKaiser` _[ARCHEOLOGY] Increase performance with rk3399-dev_ |
| ✅  | `rk356x-vop2-support` | `(+68/-79)[1M]` | b279b94b450564bff827e6598a93aa74dbb62e75 `dw_hdmi-rockchip.c` | `Miouyouyou` _[ARCHEOLOGY] [RFC] RK3288 : Add HDMI resolutions (#1887)_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+77/-0)[1A]` | 1765fee950a1693f580a4b72f0b567949c823e04 `rockchip,rk3588-crypto.yaml` | `Corentin Labbe` _dt-bindings: crypto: add support for rockchip,crypto-rk3588_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+12/-0)[1M]` | 304e55ac5824474564d05c12da278dc8d5cb96d5 `rk3588s.dtsi` | `Corentin Labbe` _ARM64: dts: rk3588: add crypto node_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+12/-0)[1M]` | 3fccfd546d1ab5ea21a170b3175dbf76d6bb99e1 `rk356x.dtsi` | `Corentin Labbe` _ARM64: dts: rk356x: add crypto node_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+34/-76)[2M]` | bf23b28fa6654fc71efaad7625d2f358231f0f6c `rockchip,rk3588-cru.h`, `rst-rk3588.c` | `Corentin Labbe` _reset: rockchip: secure reset must be used by SCMI_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+1944/-0)[2M, 4A]` | d7550b1b7b1b41c41755d43f34e1fe58dc3d59ef `rk3588_crypto.c`, `rk3588_crypto_skcipher.c`, `rk3588_crypto_ahash.c`, `rk3588_crypto.h`, `Kconfig`, `Makefile` | `Corentin Labbe` _crypto: rockchip: add rk3588 driver_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+1/-1)[1M]` | 0efc4d4dcd042ead533fc00f9d3ee7472e8a7751 `Kconfig` | `Corentin Labbe` _SM3 fix_ |
| ✅  | `wifi-4003-add-bcm43342-chip` | `(+3/-0)[2M]` | 63dacd7d4483acc05adda33acad769a548e10066 `sdio.c`, `brcm_hw_ids.h` | `Paolo Sabatino` _add broadcom bcm43342 chip id_ |
| ✅  | `wifi-4003-ssv-6051-driver` | `(+48981/-0)[2M, 58A]` | b1a2b8480d9893dd1ebd8a2b53610f205d1c3b34 `ssv6200_aux.h`, `ssv6200_reg.h`, `dev.c`, `ampdu.c`, `ssv_cmd.c`, `ssv_rc.c`, `ssv_cfgvendor.c`, `init.c`, `sdio.c`, `ssv_hci.c`, `ap.c`, `ssv_ht_rc.c`, `ssv6200_common.h`, `dev.h`, `smartlink.c`, _and 43 more_ | `Paolo Sabatino` _add ssv6xxx wifi driver_ |
| ✅  | `wifi-4003-uwe5622-adjust-for-rockchip` | `(+3472/-597)[36M, 4A]` | 2e8527b1b6c40913210ee72dc26e08459610421c `wcn_bind_helper.c`, `rfkill-wlan.c`, `rfkill-bt.c`, `cmdevt.c`, `wl_intf.c`, `wl_core.c`, `cfg80211.c`, `qos.c`, `txrx.c`, `intf_ops.h`, `wcn_wrapper.h`, `intf.h`, `sdiohal_main.c`, `npi.c`, `wcn_misc.c`, _and 23 more_ | `Paolo Sabatino` _adjust uwe5622 driver for rockchip_ |


