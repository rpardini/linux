#### kernel patching: 159 total patches; 159 applied; 0 with problems

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
|  🤖  ✅  | `[kernel-drivers/]` `sha1_a5806cd506af5a7c19bcd596e4708b5c464bfd21_rockchip64_edge_ca91ed62_509479d7-01ba4719` | `(+0/-0)[]` | 679cbde36e5c935c18faa23cbd991de7030e6b46 `?` | `Armbian Autopatcher` _[AUTOGEN] /armbian/cache/patch/kernel-drivers/sha1_a5806cd506af5a7c19bcd596e4708b5c464bfd21_rockchip64_edge_ca91ed62_509479d7-01ba4719_ |
| ✅  | `add-board-fine3399-dts` | `(+870/-0)[1A]` | e9264cd207cea7a2f37de89b27b2e1b740ad08e6 `rk3399-fine3399.dts` | `Lemon1151` _Adding support for the fine3399 board_ |
| ✅  | `add-board-helios64` | `(+635/-81)[1M]` | 6cd0150381fe81770cd67d56fdcd75818e2566b3 `rk3399-kobol-helios64.dts` | `Aditya Prayoga` _Add board Helios64_ |
| ✅  | `board-firefly-rk3399-dts` | `(+103/-30)[1M]` | 15058cc2ee65df524d6b9ba0ab1254b886535701 `rk3399-firefly.dts` | `chainsx` _[ARCHEOLOGY] firefly-rk3399: move to rockchip64 family_ |
| ✅  | `board-helios64-dts-fix-stability-issues` | `(+1/-0)[1M]` | 18546f0066d0e8e24c14cc42058abbfad089dbfe `rk3399-kobol-helios64.dts` | `Aditya Prayoga` _Attempt to improve stability on Helios64 (#2680)_ |
| ✅  | `board-helios64-remove-pcie-ep-gpios` | `(+0/-1)[1M]` | 98cb90ebbb9f19c5002d94bf1fc12cefba9a8298 `rk3399-kobol-helios64.dts` | `Aditya Prayoga` _Remove PCIE ep-gpios from Helios64_ |
| ✅  | `board-nanopc-t4-add-typec-dp` | `(+96/-0)[1M]` | 06a3ab27d9835cb0a3ad91e072bbe5971f02dd16 `rk3399-nanopc-t4.dts` | `tonymac32` _Patching something_ |
| ✅  | `board-nanopi-m4v2-dts-add-sound-card` | `(+60/-0)[2M]` | 18b24e7ac4c8ef3265c4378431918519379260e4 `rk3399-nanopi4.dtsi`, `Kconfig` | `Piotr Szczepanik` _[ARCHEOLOGY] Initial addition of NanoPi M4V2_ |
| ✅  | `board-nanopi-r2c-plus` | `(+1/-1)[1M]` | 6067869912e223f1ab48e841ad31f30a6132d914 `rk3328-nanopi-r2c-plus.dts` | `amazingfate` _[ARCHEOLOGY] rockchip64: bump rockchip64-edge kernel to 6.5_ |
| ✅  | `board-nanopi-r2s` | `(+318/-160)[2M]` | c1d5ec401edd949c7a36cd17cc688b076ecf7916 `rk3328-nanopi-r2.dtsi`, `rk3328-nanopi-r2s.dtsi` | `Paolo Sabatino` _rockchip64: consolidate nanopi r2s device trees_ |
| ✅  | `board-nanopi-r3s-fix-leds` | `(+53/-10)[3M]` | b29ec9d694902585d7f5a0728e3a07739e439f6c `rk3566-nanopi-r3s.dts`, `r8169_main.c`, `realtek_main.c` | `John Doe` _Patching NanoPi-R3S LEDs_ |
| ✅  | `board-nanopi-r4s-pwmfan` | `(+35/-0)[1M]` | 54b01270548e94303d89468f802aaeab6de60577 `rk3399-nanopi-r4s.dtsi` | `Bochun Bai` _Add pwm-fan support to nanopi r4s_ |
| ✅  | `board-odroidm1-add-nodes-for-i2c-pwm-uart-spi` | `(+34/-0)[1M]` | 614ff807f56d3ffd152704c1f9685add8a4d3b3e `rk3568-odroid-m1.dts` | `Ricardo Pardini` _rk3568-odroid-m1: add nodes for i2c/pwm/spi/uart overlays_ |
| ✅  | `board-odroidm2-fix-for-ethernet` | `(+12/-2)[1M]` | e5ddaca2e0a8481dd58b637b0d1b6606bc5a4bdf `rk3588s-odroid-m2.dts` | `Milivoje Legenovic` _[ARCHEOLOGY] Fix for ethernet warnings in dmesg output_ |
| ✅  | `board-orangepi-r1-plus` | `(+45/-0)[1M]` | 2231746da068252d984e7cf10ea08c4ca003b27b `rk3328-orangepi-r1-plus.dtsi` | `Igor Pecovnik` _[ARCHEOLOGY] Initial ROCK Pi E support (as WIP) (#2042)_ |
| ✅  | `board-orangepi-rk3399-pcie` | `(+31/-0)[1M]` | f5816148145a1a6e86e45d524a9b44b33442dcd4 `rk3399-orangepi.dts` | `amazingfate` _arm64: dts: rockchip: add pcie support to orangepi rk3399 board_ |
| ✅  | `board-orangepi3b-add-uwe5622-wifi-bt-nodes` | `(+17/-0)[1M]` | 88e38fb29b0b7631d0878f919ae996b47ebf4ad7 `rk3566-orangepi-3b-v1.1.dts` | `amazingfate` _arch: arm64: dts: add uwe5622 wifi/bt nodes to orangepi3b v1.1_ |
| ✅  | `board-pbp-add-dp-alt-mode` | `(+209/-3)[4M]` | b079b31acce95723fd69e1b18893d1246a8e731b `tcpm.c`, `displayport.c`, `phy-rockchip-typec.c`, `rk3399-pinebook-pro.dts` | `Dan Johansen` _add-dp-alt-mode-to-PBP_ |
| ✅  | `board-radxa-e25-sdmmc0-fix` | `(+1/-1)[1M]` | 70789105a14a0e816a0adb21d7f77a3bb0b46925 `rk3568-radxa-e25.dts` | `krachlatte` _[ARCHEOLOGY] Improve SD card compatibility on Radxa E25 (#5165)_ |
| ✅  | `board-radxa-e25-usb3-and-emmc-fix` | `(+14/-0)[2M]` | 659f79bae6e9042922dd7117705556e7b261fa3c `rk3568-radxa-cm3i.dtsi`, `rk3568-radxa-e25.dts` | `krachlatte` _[ARCHEOLOGY] Improve SD card compatibility on Radxa E25 (#5165)_ |
| ✅  | `board-rk3328-roc-cc-dts-enable-dmc` | `(+38/-0)[1M]` | 5c40dd48c0aefe760c4418cc1a2e8150362504b1 `rk3328-roc.dtsi` | `Paolo Sabatino` _enable roc-cc dmc_ |
| ✅  | `board-rk3328-roc-cc-dts-ram-profile` | `(+311/-0)[1A]` | 9a95b22e02f36054a65880ffcdf361d607ce9975 `rk3328-dram-renegade-timing.dtsi` | `tonymac32` _board-rk3328-roc-cc-adjust-DMC-opps_ |
| ✅  | `board-rk3328-roc-pc-dts-ram-profile` | `(+223/-0)[1A]` | fe5df3f5c6bc7515bc4f46338212761483e49cb8 `rk3328-roc-pc-dram-timing.dtsi` | `Tony` _[ARCHEOLOGY] Add files via upload_ |
| ✅  | `board-rk3328-roc-pc` | `(+466/-58)[1M]` | 93ef96255efcfff506b9d4d94b7abdd9711e6e2d `rk3328-roc-pc.dts` | `Paolo Sabatino` _enable dmc for rk3328-roc-pc_ |
| ✅  | `board-rock3a-0001-emmc-sfc` | `(+11/-0)[1M]` | 134ff4bef1e3548eb1cdf24a029ce86293a95479 `rk3568-rock-3a.dts` | `Jianfeng Liu` _[ARCHEOLOGY] update rockchip64 edge to 5.19 (#4039)_ |
| ✅  | `board-rock3a-0002-usb3` | `(+1/-0)[1M]` | 7324b2f009263993bb0cb62abd5bd1fcebb9f112 `rk3568-rock-3a.dts` | `Jianfeng Liu` _[ARCHEOLOGY] update rockchip64 edge to 5.19 (#4039)_ |
| ✅  | `board-rock3a-0003-add-gpio-names` | `(+60/-0)[1M]` | 387b5dd03a6b9ecaf2c3740bd5cadcb9736880f0 `rk3568-rock-3a.dts` | `Werner` _add gpio names for rock-3a_ |
| ✅  | `board-rock64-mail-supply` | `(+5/-0)[1M]` | 51a5f8d1097b81dd9fb3118f4168550f2af562fc `rk3328-rock64.dts` | `tonymac32` _board_rock64_mali-usb-supply_ |
| ✅  | `board-rockpi3-enable-dmc` | `(+7/-0)[1M]` | 2bf257db9e756aab16c3ee44e7a57ea31d75c7c2 `rk3328-rock-pi-e.dts` | `Paolo Sabatino` _[ARCHEOLOGY] rockchip64: enable dmc on Rock PI E board_ |
| ✅  | `board-rockpi4-0003-arm64-dts-pcie` | `(+4/-0)[1M]` | 63e1efff8b89233a03965c4b5ace56b43843bd17 `rk3399-rock-pi-4.dtsi` | `Piotr Szczepanik` _[ARCHEOLOGY] Rock Pi 4 enable PCIe in device tree for "dev" target (#1624)_ |
| ✅  | `board-rockpie-0001-arm64-dts-rockchip-fix-gmac-PHY-attach-error` | `(+1/-0)[1M]` | b4bb4690cbbb992198d0276a6eae02087a1f7302 `rk3328-rock-pi-e.dts` | `FUKAUMI Naoki` _arm64: dts: rockchip: fix gmac PHY attach error on ROCK Pi E_ |
| ✅  | `board-rockpis-dts-fixes` | `(+73/-0)[1M]` | 3af53d19266bf79b62a2b113e94eedbb4863eb16 `rk3308-rock-pi-s.dts` | `Paolo Sabatino` _rk3308: fixes for rock pi s dts_ |
| ✅  | `board-rockpro64-0001-Add-pcie-bus-scan-delay` | `(+1/-0)[1M]` | 4c68bf2cba33c7c5055d1a7bb87807f1bf86e901 `rk3399-rockpro64.dtsi` | `Piotr Szczepanik` _Rockpro64 add pcie bus scan delay_ |
| ✅  | `board-rockpro64-change-rx_delay-for-gmac` | `(+1/-1)[1M]` | b14ec7e8ff6948ed258631a16f7134d073470c89 `rk3399-rockpro64.dtsi` | `Ayufan` _ayufan: dts: rockpro64: change rx_delay for gmac_ |
| ✅  | `board-rockpro64-fix-emmc` | `(+2/-0)[1M]` | 569bfefd8bd251a96f2f9cab1901199b37250361 `rk3399-rockpro64.dtsi` | `Martin Ayotte` _rockpro64: sdhci keep-power-in-suspend and set chosen bootargs mmc_cmdqueue=0 and earlycon_ |
| ✅  | `board-rockpro64-fix-spi1-flash-speed` | `(+1/-1)[1M]` | 720971d3edd6f5e623dba46d7cc41bffab3190c2 `rk3399-rockpro64.dtsi` | `Martin Ayotte` _slow SPIFlash to avoid errors_ |
| ✅  | `board-rockpro64-work-led-heartbeat` | `(+1/-1)[1M]` | 67bc843a3ef4354962a3b53d6dce03df1fd48a68 `rk3399-rockpro64.dtsi` | `Piotr Szczepanik` _Switch RockPro64 work led to heartbeat trigger_ |
| ✅  | `board-rocks0-0001-Revert-arm64-dts-rockchip-Fix-sdmmc-access-on-rk3308` | `(+1/-24)[1M]` | a5155bff1e7bfa1a9ced2e9cd11e5fd0ca237a2d `rk3308-rock-s0.dts` | `Igor Pecovnik` _Revert "arm64: dts: rockchip: Fix sdmmc access on rk3308-rock-s0 v1.1 boards"_ |
| ✅  | `board-rocks0-0001-deviceTree` | `(+200/-146)[1M]` | eaeb613471d31cf1306fdab331a862be30694d7f `rk3308-rock-s0.dts` | `Brent Roman` _Added Linux device tree for Rock S0_ |
| ✅  | `board-station-m2` | `(+80/-30)[1M]` | c386c3ce1e509feecd5d2971855d9b9c875c433f `rk3566-roc-pc.dts` | `chainsx` _fix rk3566-roc-pc_ |
| ✅  | `board-station-p2` | `(+325/-55)[1M]` | da1e706a300b2616302f76a156c6d24431fce214 `rk3568-roc-pc.dts` | `chainsx` _[ARCHEOLOGY] fix rk3568-roc-pc_ |
| ✅  | `drv-spi-spidev-remove-warnings` | `(+2/-0)[1M]` | b1391b4b3b4cde4f19e015a7f523ab559b7dae9a `spidev.c` | `John Doe` _rockchip64: edge: 6.10.5 drv:spi:spidev remove warnings_ |
| ✅  | `general-add-hdmi-mks-ips50-resolutions` | `(+15/-1)[4M]` | ab76fbad8e1a065467f9a636145e786003d1be86 `drm_edid.c`, `hdmi.c`, `phy-rockchip-inno-hdmi.c`, `hdmi.h` | `Maxim Medvedev` _HDMI EDID records for 800x480 resolution (a MKS IPS50 screen and similar)_ |
| ✅  | `general-add-miniDP-dt-doc` | `(+66/-0)[1A]` | 939587d72a3bbd393a53cb3591cf53df775e69bc `extcon-usbc-virtual-pd.yaml` | `Tony` _[ARCHEOLOGY] RK3399 Typec DP (#2676)_ |
| ✅  | `general-add-miniDP-virtual-extcon` | `(+296/-0)[2M, 1A]` | 31805be4d854a4be994d1b0faadfef422ce71f4d `extcon-usbc-virtual-pd.c`, `Kconfig`, `Makefile` | `Tony` _[ARCHEOLOGY] RK3399 Typec DP (#2676)_ |
| ✅  | `general-add-overlay-compilation-support` | `(+19/-2)[2M]` | 337c1fd0ac30b718cd3f770aafe66dc23a049bb8 `Makefile.dtbinst`, `Makefile.dtbs` | `Paolo Sabatino` _compile .scr and install overlays in right path_ |
| ✅  | `general-add-overlay-configfs` | `(+320/-0)[2M, 2A]` | a9121ca9017b30b97df1f020bc9a3f675e10cfa6 `configfs.c`, `configfs-overlays.txt`, `Kconfig`, `Makefile` | `Pantelis Antoniou` _OF: DT-Overlay configfs interface_ |
| ✅  | `general-add-panel-simple-dsi` | `(+773/-0)[1M, 1A]` | 51d7c4139dd2ad441e4db633188b3926e3137220 `panel-simple-dsi.c`, `Makefile` | `simple` _[ARCHEOLOGY] general add panel simple dsi (#3140)_ |
| ✅  | `general-add-pll-hdmi-timings` | `(+71/-0)[1M]` | 0aa84e53fc5b58352d694e41f5e4615f939b869e `phy-rockchip-inno-hdmi.c` | `paolo` _[ARCHEOLOGY] Adding pll hdmi timing to rockchip64-dev too_ |
| ✅  | `general-add-xtx-spi-nor-chips` | `(+24/-0)[3M, 1A]` | d31e555ade67bd76386c43aafeaaad5710032e20 `xtx.c`, `Makefile`, `core.c`, `core.h` | `microcai` _spi-nor: Add support for xt25f32b/xt25f128b_ |
| ✅  | `general-clk-rockchip-rk3568-Add-PLL-rate-for-33.3MHz` | `(+1/-0)[1M]` | ab4ffd0682181f54d1ff396820ef0b2fe0976263 `clk-rk3568.c` | `Vasily Khoruzhick` _clk: rockchip: rk3568: Add PLL rate for 33.3MHz_ |
| ✅  | `general-cryptov1-trng` | `(+140/-1)[6M, 1A]` | 46a3bc9f2bf33266b164ad42b99e386959c3e209 `rk3288_crypto_trng.c`, `rk3288_crypto.c`, `rk3288_crypto.h`, `Kconfig`, `rk3288_crypto_ahash.c`, `rk3288_crypto_skcipher.c`, `Makefile` | `Paolo Sabatino` _rockchip64: add TRNG to existing crypto v1 driver_ |
| ✅  | `general-disable-mtu-validation` | `(+0/-12)[1M]` | cf8df5acb8ea523401b876db18d5e97e72b108fe `stmmac_main.c` | `Igor Pecovnik` _Disable MTU validation_ |
| ✅  | `general-driver-tm16xx-led-driver` | `(+1178/-0)[2M, 1A]` | be7a4d6bc9b67788582443997b1000336390e92a `tm16xx.c`, `Kconfig`, `Makefile` | `Paolo Sabatino` _Add tm16xx led auxiliary display driver_ |
| ✅  | `general-drm-rockchip-Set-dma-mask-to-64-bit` | `(+3/-1)[1M]` | 97ddbd3337779254a8b69d5b7ef964d8b700f6d8 `rockchip_drm_drv.c` | `SuperKali` _drm/rockchip: Set dma mask to 64 bit_ |
| ✅  | `general-fix-es8316-kernel-panic` | `(+1/-1)[1M]` | 49abc6171362136fbf20e211cf3688232ed8ca22 `es8316.c` | `Yannick Adam` _[ARCHEOLOGY] Enable es8316 on RockPi4 (#1885)_ |
| ✅  | `general-fix-mmc-signal-voltage-before-reboot` | `(+8/-0)[1M]` | 631322de5a952685b18b605561dd1f9ea357e845 `core.c` | `Jonas Karlman` _mmc: core: set initial signal voltage on power off_ |
| ✅  | `general-hdmi-clock-fixes` | `(+97/-13)[4M]` | 94dc1a2f99ed30b92f56bed9ae7450e53655411b `clk-rk3399.c`, `dw_hdmi-rockchip.c`, `dw-hdmi.c`, `rockchip_vop_reg.c` | `Paolo Sabatino` _hdmi timing core changes and fixes_ |
| ✅  | `general-increase-spdif-dma-burst` | `(+1/-1)[1M]` | d29585a85ac17ed6b4c987814f874ce8a56178cf `rockchip_spdif.c` | `Paolo Sabatino` _rockchip: increase SPDIF max burst value to maximum_ |
| ✅  | `general-increasing_DMA_block_memory_allocation_to_2048` | `(+3/-5)[1M]` | a1fa94dab1a960ed92192dde3f62a3cfbd3efadd `pool.c` | `Igor Pecovnik` _[ARCHEOLOGY] Increasing DMA block memory allocation to 2048k on all relevant kernels._ |
| ✅  | `general-pl330-01-fix-periodic-transfers` | `(+186/-91)[1M]` | 45124bbb5c2c34104697a8d5d0bccbf884b97262 `pl330.c` | `Paolo Sabatino` _pl330: fix dma engine periodic transfers_ |
| ✅  | `general-pl330-02-add-support-for-interleaved-transfers` | `(+163/-6)[2M]` | 14775ded8c71bb37101f4dd927d9e2f791cd20cc `pl330.c`, `dmaengine.h` | `Paolo Sabatino` _rockchip/64: pl330 - add support for interleaved transfers_ |
| ✅  | `general-pl330-04-bigger-mcode-buffer` | `(+1/-1)[1M]` | f17ffb7dbe7e7972f766df94723e6430c103ee5a `pl330.c` | `Paolo Sabatino` _increase pl330 microcode buffer size_ |
| ✅  | `general-pl330-05-fix-unbalanced-power-down` | `(+1/-1)[1M]` | 39bca1b7aa28e80d9d9818bb00c1cd3a9ba7369b `pl330.c` | `Sugar Zhang` _dmaengine: pl330: Fix unbalanced runtime PM_ |
| ✅  | `general-pl330-06-fix-buffer-underruns` | `(+12/-12)[1M]` | 606fa60b2edd54b83fd5886e205c0dbb5b58d05a `pl330.c` | `Paolo Sabatino` _pl330: fix buffer underrun with cyclic dma_ |
| ✅  | `general-possibility-of-disabling-rk808-rtc` | `(+2/-1)[2M]` | b2066a788c7fa3ea3f2bb287a5a7d851f806240a `mfd-core.c`, `rk8xx-core.c` | `Piotr Szczepanik` _add possibility of disabling rk808-rtc_ |
| ✅  | `general-rk3328-dtsi-trb-ent-quirk` | `(+1/-0)[1M]` | 1ca9016bb4664df4811c25c6779681ecb8ba8718 `rk3328.dtsi` | `schwar3kat` _[ARCHEOLOGY] Enable rockchip64: XHCI HCD USB TRB ENT quirk for RK3328 (#3763)_ |
| ✅  | `general-rk808-configurable-switch-voltage-steps` | `(+13/-4)[1M]` | b8bb68289da2b4c73304e24ceb80df4ecbdc6c6e `rk808-regulator.c` | `Piotr Szczepanik` _allows to change the way that BUCK1 and BUCK2 of rk808 PMIC_ |
| ✅  | `general-rockchip-overlays` | `(+3/-0)[1M]` | 29eec9bde12a786b83ddc27bd616518278df682b `Makefile.lib` | `Martin Ayotte` _add overlays framework for rockchip (scripts/Makefile.lib only)_ |
| ✅  | `general-rt5651-add-mclk` | `(+17/-0)[2M]` | 03c97f7d73f38b3b8c49e43ad6abab7b8a4416f8 `rt5651.c`, `rt5651.h` | `Piotr Szczepanik` _[ARCHEOLOGY] Fixed sound from rt5651 on OrangePi 4 (#1870)_ |
| ✅  | `general-st7796-driver` | `(+161/-0)[2M, 1A]` | df1be4e63f588eea542348f0b25c1bb581b82ad8 `fb_st7796.c`, `Kconfig`, `Makefile` | `Maxim Medvedev` _Custom st7796 display module_ |
| ✅  | `general-v4l2-iep-driver` | `(+1632/-1)[5M, 6A]` | d1a8f1829d244d3d60dfa90c9fca49a3f18435e0 `iep.c`, `iep-regs.h`, `iep.h`, `rockchip-iep.yaml`, `rk3328.dtsi`, `rk3288.dtsi`, `rk3399-base.dtsi`, `Kconfig`, `Makefile` | `Paolo` _Rockchip IEP driver_ |
| ✅  | `general-v4l2-rkvdec-00-fixes` | `(+38/-39)[1M]` | 58422487452493d83bed1d9a2f6e30cf79c4934e `v4l2-common.c` | `Jonas Karlman` _media: v4l2-common: Add helpers to calculate bytesperline and sizeimage_ |
| ✅  | `general-v4l2-rkvdec-00-fixes` | `(+8/-0)[3M]` | 30398feca83277e1509339f4eab411f18b841748 `v4l2-common.c`, `videodev2.h`, `v4l2-ioctl.c` | `Jonas Karlman` _media: v4l2: Add NV15 and NV20 pixel formats_ |
| ✅  | `general-v4l2-rkvdec-00-fixes` | `(+5/-5)[1M]` | e42d02effdd6a81e2d433fbffb8b1e66d4a93503 `rkvdec-h264.c` | `Jonas Karlman` _media: rkvdec: h264: Use bytesperline and buffer height to calculate stride_ |
| ✅  | `general-v4l2-rkvdec-00-fixes` | `(+15/-14)[1M]` | 4f755ded20066040086a0610100b75829067bfa4 `rkvdec.c` | `Jonas Karlman` _media: rkvdec: Extract rkvdec_fill_decoded_pixfmt helper method_ |
| ✅  | `general-v4l2-rkvdec-00-fixes` | `(+61/-8)[2M]` | 890ffaf7553c738ea1bdd0d63ede0cc5d640aee6 `rkvdec.c`, `rkvdec.h` | `Jonas Karlman` _media: rkvdec: Lock capture pixel format in s_ctrl and s_fmt_ |
| ✅  | `general-v4l2-rkvdec-00-fixes` | `(+37/-15)[2M]` | 8c12f79dafb94a6c0aa6ac8e58bb44ee14a42d68 `rkvdec-h264.c`, `rkvdec.c` | `Jonas Karlman` _media: rkvdec: h264: Support High 10 and 4:2:2 profiles_ |
| ✅  | `general-v4l2-rkvdec-00-fixes` | `(+7/-6)[1M]` | cdb8f3a39f4991083e6be09fc1b7be6452fb0bae `rkvdec-h264.c` | `Alex Bee` _media: rkvdec-h264: Don't hardcode SPS/PPS parameters_ |
| ✅  | `general-v4l2-rkvdec-01-vp9` | `(+2/-2)[1M]` | 511c1757b0a7e8467f6790688be51dd6a73a1336 `rkvdec.c` | `Jonas Karlman` _WIP: media: rkvdec: pm runtime dont use autosuspend before disable and cleanup_ |
| ✅  | `general-v4l2-rkvdec-01-vp9` | `(+44/-0)[2M, 1A]` | 75fe52041feb5a1e585a28038a0e90eec979b049 `pm-domains.c`, `rockchip_pmu.h`, `pm_domains.h` | `Randy Li` _soc: rockchip: power-domain: export idle request_ |
| ✅  | `general-v4l2-rkvdec-01-vp9` | `(+87/-1)[4M]` | 2686597e266c45b5286ea75e34cf217f979ba6f7 `rkvdec.c`, `rockchip,vdec.yaml`, `rkvdec.h`, `rkvdec-regs.h` | `Alex Bee` _WIP: media: rkvdec: implement reset controls_ |
| ✅  | `general-v4l2-rkvdec-01-vp9` | `(+11/-3)[1M]` | 5cc654080370acc8eeb12768db896d7d1b021f62 `rockchip_vpu_hw.c` | `Alex Bee` _media: hantro: rockchip: Increase RK3288's max ACLK_ |
| ✅  | `general-v4l2-rkvdec-01-vp9` | `(+10/-0)[2M]` | e25470f7214461816cf66cf910b2df3c4c783160 `rkvdec-vp9.c`, `rkvdec-regs.h` | `Alex Bee` _media: rkvdec: disable QoS for VP9 (corruptions on RK3328 otherwise)_ |
| ✅  | `general-v4l2-rkvdec-01-vp9` | `(+5/-0)[1M]` | 53d0efab0b13eb76f88031d92867195b88fc0fca `rk3328.dtsi` | `Alex Bee` _WIP: arm64: dts: add resets to vdec for RK3328_ |
| ✅  | `general-v4l2-rkvdec-02-hevc` | `(+2647/-2)[4M, 1A]` | e9740ffc49b6acc5698cfe42e6b78999251ec850 `rkvdec-hevc.c`, `rkvdec.c`, `Makefile`, `rkvdec-regs.h`, `rkvdec.h` | `Jonas Karlman` _WIP: media: rkvdec: add HEVC backend_ |
| ✅  | `general-v4l2-rkvdec-02-hevc` | `(+85/-30)[2M]` | 948698debd5defe57937d4c53207b8ba0f24df39 `rkvdec.c`, `rkvdec.h` | `Alex Bee` _media: rkvdec: add variants support_ |
| ✅  | `general-v4l2-rkvdec-02-hevc` | `(+8/-0)[1M]` | 909bebe4baa1c83f037394f9007149ea1a390136 `rkvdec.c` | `Alex Bee` _media: rkvdec: add RK3288 variant_ |
| ✅  | `general-v4l2-rkvdec-02-hevc` | `(+20/-1)[1M]` | 36192aac6b003c1fa5b4075840711be8ba869101 `rk3288.dtsi` | `Alex Bee` _ARM: dts: RK3288: add hevc node_ |
| ✅  | `general-v4l2-rkvdec-02-hevc` | `(+23/-3)[1M]` | 69438c75ddcf75c491fc0dc8f3d43464312f0957 `rkvdec-hevc.c` | `Nicolas Dufresne` _media: rkvdec: Fix HEVC RPS bit offsets_ |
| ✅  | `general-v4l2-rkvdec-02-hevc` | `(+4/-2)[1M]` | 0f5280c7792623f9a0ccfc2549dc49fd4a1f9454 `rkvdec-hevc.c` | `Nicolas Dufresne` _media: rkvdec: Fix number of HEVC references being set in RPS_ |
| ✅  | `general-workaround-broadcom-bt-serdev` | `(+1/-1)[1M]` | 66919dfad2fe4e166caf9f992b56c713177600ca `btbcm.c` | `Paolo Sabatino` _Workaround to make several broadcom bluetooth serdev devices work even without proper MAC address_ |
| ✅  | `kernel-6.8-tools-cgroup-makefile` | `(+11/-0)[1A]` | 03d06d6e05f2862558e46cfff7d7c005542fcf8b `Makefile` | `Paolo Sabatino` _[ARCHEOLOGY] rockchip: bump edge kernel to 6.8_ |
| ✅  | `media-0001-Add-rkvdec2-Support-v3` | `(+510/-499)[1M, 1A]` | f1e7fc72ec691e7ca750a40203d48d780c6e398a `rkvdec-h264-cabac.h`, `rkvdec-h264.c` | `Detlev Casanova` _media: rockchip: Move H264 CABAC table to header file_ |
| ✅  | `media-0001-Add-rkvdec2-Support-v3` | `(+2496/-0)[2M, 7A]` | 5a207804127652a3ef6cf099f9fa9236564b2e61 `rkvdec2.c`, `rkvdec2-h264.c`, `rkvdec2-regs.h`, `rkvdec2.h`, `Kconfig`, `TODO`, `Makefile` | `Detlev Casanova` _media: rockchip: Introduce the rkvdec2 driver_ |
| ✅  | `media-0001-Add-rkvdec2-Support-v3` | `(+50/-0)[1M]` | 7984a8d7e1aaf8249ba7f5bbdb3b1799e03f15d7 `rk3588-base.dtsi` | `Detlev Casanova` _arm64: dts: rockchip: Add rkvdec2 Video Decoder on rk3588(s)_ |
| ✅  | `media-0002-v4l2-core-Initialize-h264-frame_mbs_only_flag-` | `(+13/-0)[1M]` | 461f7e19286ca620fc8299bba7c1eca762bf42c8 `v4l2-ctrls-core.c` | `amazingfate` _media: v4l2-core: Initialize h264 frame_mbs_only_flag as 1_ |
| ✅  | `media-0003-rk3568-disable-hantro-h264` | `(+4/-21)[4M]` | 04342b1c1a92bf603cf7a1c31e021eca183bbf84 `rockchip_vpu_hw.c`, `rk3588-base.dtsi`, `hantro_drv.c`, `hantro_hw.h` | `amazingfate` _[ARCHEOLOGY] rockchip64-edge: disable hantro g1 h264 decoder on rk356x_ |
| ✅  | `net-usb-r8152-add-LED-configuration-from-OF` | `(+23/-0)[1M]` | 0cf880b509127519582bb8db36fe728581e55cdb `r8152.c` | `David Bauer` _net: usb: r8152: add LED configuration from OF_ |
| ✅  | `regulator-add-fan53200-driver` | `(+533/-0)[3M, 1A]` | 217a5290334c35e37cbf40a1593440395bbe27b3 `fan53200.c`, `Kconfig`, `defconfig`, `Makefile` | `Rock Shen` _regulator: add fan53200 regulator driver for Tinkerboard-2_ |
| ✅  | `rk3308-0001-pinctrl-slew-mux` | `(+100/-0)[4M]` | 54478d10404d4053a04d0fb8d19fbbc26c952109 `pinctrl-rockchip.c`, `pinctrl-rockchip.h`, `pinconf-generic.c`, `pinconf-generic.h` | `brentr` _[ARCHEOLOGY] Rockpis wifi fixes (#4008)_ |
| ✅  | `rk3308-0003-pinctrl-io-voltage-domains` | `(+24/-40)[2M]` | 9974cf198241cc80f2bcec141bdea5206e65f0a1 `io-domain.c`, `pinctrl-rockchip.c` | `brentr` _[ARCHEOLOGY] Rockpis wifi fixes (#4008)_ |
| ✅  | `rk3308-add-gmac-alias` | `(+1/-0)[1M]` | b4c18511e71ecc18b76ce4f3e6bbf36486299a4e `rk3308.dtsi` | `ashthespy` _arm64: dts: rk3308: Add mac node at dtsi level_ |
| ✅  | `rk3308-add-missing-i2s-controllers` | `(+59/-0)[1M]` | b1cd4a38898bd21e540be600193d28a54289a2eb `rk3308.dtsi` | `Paolo Sabatino` _add missing i2s controllers_ |
| ✅  | `rk3308-add-tsadc-driver` | `(+27/-0)[2M]` | 106af9187ac53be1e0bc0ddcf62cddc885864cf3 `rockchip_thermal.c`, `rockchip-thermal.yaml` | `Rocky Hao` _thermal: rockchip: add tsadc support for rk3308_ |
| ✅  | `rk3308-dts-legacy-cryptov2` | `(+15/-0)[1M]` | 110fa18dd13c6a258bc889dd6e13b9f39c1fc695 `rk3308.dtsi` | `Paolo Sabatino` _rk3308: add cryptov2 dts node_ |
| ✅  | `rk3308-dts-thermal-zones` | `(+64/-0)[1M]` | ac60daf212acb80cff1b5730a66f5b456126f5c5 `rk3308.dtsi` | `ashthespy` _arm64: dts: rockchip: add cpu's thermal config for rk3308_ |
| ✅  | `rk3308-fix-uart-dma` | `(+24/-0)[2M]` | d2c928cd903a7f8ca428996d4348f05c04d7be8c `grf.c`, `rk3308.dtsi` | `ssp97` _rk3308: fix uart dma._ |
| ✅  | `rk3308-internal-rgb-lcdc` | `(+3/-0)[1M]` | caed10922b751d8dbe554f1a1d20ab96c83a2ac4 `rockchip_rgb.c` | `TheSnowfield` _rk3308: set pinmux for internal RGB output_ |
| ✅  | `rk3308-vop-output` | `(+272/-0)[3M]` | c9f9a13cfd7f161c8c34daeee349da77ade22c04 `rk3308.dtsi`, `rockchip_vop_reg.c`, `rockchip_vop_reg.h` | `TheSnowfield` _rk3308: rk3308 vop output_ |
| ✅  | `rk3328-add-dmc-driver` | `(+1692/-14)[8M, 6A]` | d7cdc33627c09007cc7c11f624e52375400d0773 `rk3328_dmc.c`, `rk3328-dram-default-timing.dtsi`, `rk3328-dram.h`, `clk-ddr.c`, `rockchip-dfi.c`, `rockchip-ddr.h`, `rk3328.dtsi`, `rk3228_grf.h`, `rk3328_grf.h`, `clk-rk3328.c`, `Kconfig`, `rockchip_sip.h`, `clk.h`, `Makefile` | `Paolo Sabatino` _rk3328 dmc driver_ |
| ✅  | `rk3328-add-rga-node` | `(+14/-0)[1M]` | 1d21f29a162f1297cb71163cea2944f8bd737ca6 `rk3328.dtsi` | `Paolo Sabatino` _rk3328: add RGA node_ |
| ✅  | `rk3328-dtsi-mali-opp-table` | `(+25/-0)[1M]` | c7392825b6d8b46861d4f4b19b6bce7db0c1a127 `rk3328.dtsi` | `Paolo Sabatino` _gpu operating points_ |
| ✅  | `rk3328-dtsi-spdif` | `(+27/-0)[1M]` | b1246f43fdb1e27afaec5d411896453a7a05d1ba `rk3328.dtsi` | `Paolo Sabatino` _[ARCHEOLOGY] rockchip64: tidy up rk3328 patches_ |
| ✅  | `rk3328-dtsi-usb3-reset-properties` | `(+2/-0)[1M]` | 0ce83e0bbd52f3d3628417eaa990560f02f9077f `rk3328.dtsi` | `Paolo Sabatino` _usb3 reset properties_ |
| ✅  | `rk3328-gpu-cooling-target` | `(+6/-0)[1M]` | 3c95c01fff2bacf10b521ce803530c1a34b49451 `rk3328.dtsi` | `tonymac32` _rk3328-gpu-cooling-target_ |
| ✅  | `rk3328-roc-cc-add-missing-nodes` | `(+32/-0)[1M]` | 00b928df8030b8afdbf3ee120fe47ea096b56c7e `rk3328-roc.dtsi` | `tonymac32` _rk3328-roc-cc add missing nodes_ |
| ✅  | `rk3399-add-sclk-i2sout-src-clock` | `(+2/-1)[2M]` | 9146f56b6eb762ec7c6926b5779352bae9c640bc `clk-rk3399.c`, `rk3399-cru.h` | `Piotr Szczepanik` _[ARCHEOLOGY] Fixed sound from rt5651 on OrangePi 4 (#1870)_ |
| ✅  | `rk3399-dmc-polling-rate` | `(+1/-1)[1M]` | daa54ffd3b6ca7b6a0c489ca3d4f1ba854a6d32a `rk3399_dmc.c` | `Paolo Sabatino` _[ARCHEOLOGY] rockchip64: set poll rate 50ms for rk3399 dmc driver_ |
| ✅  | `rk3399-enable-dwc3-xhci-usb-trb-quirk` | `(+2/-0)[1M]` | 0a690bc064fa43aa0cd1447f0d5135ded3a3b79c `rk3399-base.dtsi` | `Aditya Prayoga` _[ARCHEOLOGY] Fix 2.5G Ethernet on Helios64 Mainline kernel (#2567)_ |
| ✅  | `rk3399-fix-pci-lanes` | `(+6/-6)[1M]` | 0c297f456e40829da4a276eb0d6c8b9d8bec82b4 `phy-rockchip-pcie.c` | `Valmantas Paliksa` _Disable PHY_LANE_IDLE_OFF for each instance of rockchip_pcie_phy_power_one_ |
| ✅  | `rk3399-fix-pci-phy` | `(+16/-0)[1M]` | 9b036c09220506ebf1a80bcbee455969fa3af14b `phy-rockchip-pcie.c` | `Andrey Safonov` _rk3399 PCIE PHY reset on probe_ |
| ✅  | `rk3399-fix-usb-phy` | `(+1/-1)[1M]` | 8135ae264b36fe3cf2443b6df788f1e999d36196 `phy-rockchip-typec.c` | `Paolo Sabatino` _increase timeout for usb3 type C phy init_ |
| ✅  | `rk3399-rp64-pcie-Reimplement-rockchip-PCIe-bus-scan-delay` | `(+41/-0)[4M]` | a33af915571b2f12d95e6bd6b662d3673ed31cf9 `pcie-rockchip-host.c`, `kernel-parameters.txt`, `pcie-rockchip.c`, `pcie-rockchip.h` | `Dan Pasanen` _add pcie hack bus-scan-delay-ms_ |
| ✅  | `rk3399-sd-drive-level-8ma` | `(+8/-8)[1M]` | 253cc0575a76b3ed8a67384b5140226c683b4227 `rk3399-base.dtsi` | `Martin Ayotte` _[ARCHEOLOGY] add better strength on SDCard and put back previous speed setting_ |
| ✅  | `rk3399-sd-pwr-pinctrl` | `(+5/-0)[1M]` | 3f100e6b19c2a373ee9fd3c14e0febf1a0fcb7f2 `rk3399-base.dtsi` | `Paolo Sabatino` _rk3399: add sd power pin to pinctrl node_ |
| ✅  | `rk3399-unlock-temperature` | `(+3/-3)[1M]` | 80641dfc9ca3ef77bcf1a758616b4d68bc3083de `rk3399-base.dtsi` | `ThomasKaiser` _[ARCHEOLOGY] Increase performance with rk3399-dev_ |
| ✅  | `rk356x-add-rkvdec2-support` | `(+34/-1)[1M]` | 6dfca6b9b24ab2cefbea39804a52dfe5e0b47e29 `rk356x-base.dtsi` | `amazingfate` _[ARCHEOLOGY] rockchip64-edge: add rkvdec2 for rk356x_ |
| ✅  | `rk3588-0010-fix-clk-divisions` | `(+11/-0)[1M]` | 9b49cde3fd1458d7acf02b2d02f1d7982f3b3c57 `math.h` | `Sebastian Reichel` _math.h: add DIV_ROUND_UP_NO_OVERFLOW_ |
| ✅  | `rk3588-0010-fix-clk-divisions` | `(+3/-3)[1M]` | 8298032a6b16b91b44edc15c4f99eccb63a601f9 `clk-divider.c` | `Sebastian Reichel` _clk: divider: Fix divisor masking on 64 bit platforms_ |
| ✅  | `rk3588-0010-fix-clk-divisions` | `(+2/-4)[1M]` | 66aabecfeb5a74f3c6c324c4adf8c24ea09d6b61 `clk-composite.c` | `Sebastian Reichel` _clk: composite: replace open-coded abs_diff()_ |
| ✅  | `rk3588-0025-add-missing-op-nodes` | `(+58/-0)[1M]` | dfb1d1c2ece1271d574cd7fe5e28dc9bb13d07aa `rk3588-opp.dtsi` | `SuperKali` _Rockchip RK3588 adding missing opp nodes_ |
| ✅  | `rk3588-1010-arm64-dts-rock-5b-Slow-down-emmc-to-hs200-and-add-ts` | `(+5/-0)[1M]` | f2b7594e07595681510d9332758e1680c64e95cc `rk3588-rock-5b.dts` | `amazingfate` _arm64: dts: rock-5b: Slow down emmc freq and add tsadc node_ |
| ✅  | `rk3588-1040-board-khadas-edge2-add-nodes` | `(+119/-0)[1M]` | 09e12147f331c65238935b2d7abfd39dcc60bceb `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add USB-C to Khadas Edge 2_ |
| ✅  | `rk3588-1040-board-khadas-edge2-add-nodes` | `(+17/-1)[1M]` | e7f22bfb4bb10238b36c8112ae642bbf916afb85 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add bluetooth support to Khadas Edge 2_ |
| ✅  | `rk3588-1040-board-khadas-edge2-add-nodes` | `(+47/-0)[1M]` | 81efb848c1a113fdade8bd5224321610eb909386 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add HDMI & VOP2 to Khadas Edge 2_ |
| ✅  | `rk3588-1041-board-khadas-edge2-mcu` | `(+30/-2)[2M]` | a6cc8e8578f8211549e8e294e93ca9cb643d93dc `khadas-mcu.h`, `khadas-mcu.c` | `Muhammed Efe Cetin` _mfd: khadas-mcu: add Edge2 registers_ |
| ✅  | `rk3588-1041-board-khadas-edge2-mcu` | `(+0/-11)[1M]` | 9f27a927bac578bd2241df7aebc5deefb893dddc `khadas-mcu.c` | `Muhammed Efe Cetin` _mfd: khadas-mcu: drop unused code_ |
| ✅  | `rk3588-1041-board-khadas-edge2-mcu` | `(+73/-4)[1M]` | a75f7d3347421fb3b6fc2e340ce4a08c62cffd32 `khadas_mcu_fan.c` | `Muhammed Efe Cetin` _thermal: khadas_mcu_fan: add support for Khadas Edge 2_ |
| ✅  | `rk3588-1041-board-khadas-edge2-mcu` | `(+6/-1)[1M]` | d52f43fe13a4d6967a0f2c34b91e769fcad10246 `khadas,mcu.yaml` | `Muhammed Efe Cetin` _dt-bindings: mfd: khadas-mcu: add cooling-levels property_ |
| ✅  | `rk3588-1041-board-khadas-edge2-mcu` | `(+7/-0)[1M]` | 39ad5965eadab010e20bd4d7fafda6c136c5c216 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add MCU to Khadas Edge 2_ |
| ✅  | `rk3588-1041-board-khadas-edge2-mcu` | `(+56/-0)[1M]` | c4dff2d3ebcb80b47439b9d34d338e00a28b5db8 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add automatic fan control to Khadas Edge 2_ |
| ✅  | `rk3588-1051-board-nanopc-t6-fan-support` | `(+36/-0)[1M]` | 141632088b98645e4148852f1eee48ffe98149a6 `rk3588-nanopc-t6.dtsi` | `SuperKali` _Adding FAN support for NanoPC T6 & LTS_ |
| ✅  | `rk3588-1052-board-nanopc-t6-fix-usb3-a` | `(+2/-0)[1M]` | 8066f1b77549452bd7fda94953bfe7c1c9dd861a `rk3588-nanopc-t6.dtsi` | `SuperKali` _Fixing USB-A 3.0 on NanoPC T6_ |
| ✅  | `rk3588-1053-board-nanopc-t6-hdmi1-and-audio-support` | `(+56/-0)[1M]` | 2ba54d3c4c218b6be1fe7d3ed8518d1b7f183c75 `rk3588-nanopc-t6.dtsi` | `SuperKali` _Add HDMI1 support and Audio for NanoPC T6 & LTS_ |
| ✅  | `rk3588-1063-arm64-dts-rockchip-Enable-automatic-fan-control-on-t` | `(+31/-1)[1M]` | 86340bcb4a32e0183d438b71ece75fc06e9f3e16 `rk3588-turing-rk1.dtsi` | `Joshua Riek` _arm64: dts: rockchip: Enable automatic fan control on the Turing RK1_ |
| ✅  | `rk3588-1064-arm64-dts-rockchip-Add-missing-hym8563-clock-frequen` | `(+1/-0)[1M]` | 436a531a6ad942253ae9887aca3695d0ef2d560b `rk3588-turing-rk1.dtsi` | `Joshua Riek` _arm64: dts: rockchip: Add missing hym8563 clock-frequency for Turing RK1_ |
| ✅  | `rk3588-1072-arm64-dts-rockchip-add-AP6275P-wifi-to-Orange-Pi-5B` | `(+33/-0)[1M]` | e9f6cec8f3ffd1c0b61254352193e86d7f38b752 `rk3588s-orangepi-5b.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: add AP6275P wifi to Orange Pi 5B_ |
| ✅  | `rk3588-1080-arm64-dts-rockchip-add-USB3-support-to-NanoPi-R6-ser` | `(+19/-0)[1M]` | 23de517e1564c9e4c1c877d90b14ab61b11efbbf `rk3588s-nanopi-r6.dtsi` | `Muhammed Efe Cetin` _arm64: dts: rockchip: add USB3 support to NanoPi R6 series boards_ |
| ✅  | `rk3588-1100-arm64-dts-rockchip-opi5-max-add-2nd-hdmi` | `(+42/-0)[1M]` | 08198fb2e34f0af4c702d6da6ac3ea44f665b164 `rk3588-orangepi-5-max.dts` | `palachzzz` _[ARCHEOLOGY] RK3588 add HDMI sound, add support for OPi5 Max #7884_ |
| ✅  | `rk3588-1101-arm64-dts-rockchip-opi5-max-add-hdmi-sound` | `(+16/-0)[1M]` | c569754f8def5cac42fcac75a25a91a7a26180a0 `rk3588-orangepi-5-max.dts` | `palachzzz` _[ARCHEOLOGY] RK3588 add HDMI sound, add support for OPi5 Max #7884_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+65/-0)[1A]` | 7eca98483bade703967669462cd8a38929c25294 `rockchip,rk3588-crypto.yaml` | `Corentin Labbe` _dt-bindings: crypto: add support for rockchip,crypto-rk3588_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+12/-0)[1M]` | 8bd4be39780c5120ccfd6b2350a960ba98811198 `rk3588-base.dtsi` | `Corentin Labbe` _ARM64: dts: rk3588: add crypto node_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+12/-0)[1M]` | 2a41eace1fca350158ab6bb9d33ca9fb1ff0a2a0 `rk356x-base.dtsi` | `Corentin Labbe` _ARM64: dts: rk356x: add crypto node_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+34/-76)[2M]` | 92d90ea03284469acf0ec263fd83f8aa06d1870d `rockchip,rk3588-cru.h`, `rst-rk3588.c` | `Corentin Labbe` _reset: rockchip: secure reset must be used by SCMI_ |
| ✅  | `rk35xx-montjoie-crypto-v2-rk35xx` | `(+1939/-0)[2M, 4A]` | 335600789e125ddf0d817857ba4ab97d53f875c9 `rk2_crypto.c`, `rk2_crypto_skcipher.c`, `rk2_crypto_ahash.c`, `rk2_crypto.h`, `Kconfig`, `Makefile` | `Corentin Labbe` _crypto: rockchip: add rk3588 driver_ |
| ✅  | `wifi-4003-add-bcm43342-chip` | `(+3/-0)[2M]` | 2dda7016e5f102caf2f72bcc2e1990ddd9a70293 `sdio.c`, `brcm_hw_ids.h` | `Paolo Sabatino` _add broadcom bcm43342 chip id_ |
| ✅  | `wifi-4003-ssv-6051-driver` | `(+48982/-0)[2M, 58A]` | cceb998db11dd52bb2974c9f53207c548f6734c6 `ssv6200_aux.h`, `ssv6200_reg.h`, `dev.c`, `ampdu.c`, `ssv_cmd.c`, `ssv_rc.c`, `ssv_cfgvendor.c`, `init.c`, `sdio.c`, `ssv_hci.c`, `ap.c`, `ssv_ht_rc.c`, `ssv6200_common.h`, `dev.h`, `smartlink.c`, _and 43 more_ | `Paolo Sabatino` _add ssv6xxx wifi driver_ |
| ✅  | `wifi-4004-ssv6051-fix-build-for-6.15-del_timer_sync-timer_dele` | `(+8/-0)[2M]` | d72c89115c5b142f55fbf88f50b9e7b087ee4322 `dev.c`, `init.c` | `Ricardo Pardini` _ssv6051: fix build for 6.15 (2x del_timer_sync->timer_delete_sync)_ |


