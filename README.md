#### kernel patching: 59 total patches; 59 applied; 0 with problems

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
|  🤖  ✅  | `[kernel-drivers/]` `sha1_90d35da658da8cff0d4ecbb5113f5fac9d00eb72_rockchip-rk3588_edge_7b5ee01d_2f99f672-01ba4719` | `(+0/-0)[]` | 82f989eb3f1f9c1418f4e3debbfc55c346f17760 `?` | `Armbian Autopatcher` _[AUTOGEN] /armbian/cache/patch/kernel-drivers/sha1_90d35da658da8cff0d4ecbb5113f5fac9d00eb72_rockchip-rk3588_edge_7b5ee01d_2f99f672-01ba4719_ |
| ✅  | `0010-fix-clk-divisions` | `(+11/-0)[1M]` | b8f0c6e45dbce924609e952b5388d8a85339b49e `math.h` | `Sebastian Reichel` _math.h: add DIV_ROUND_UP_NO_OVERFLOW_ |
| ✅  | `0010-fix-clk-divisions` | `(+3/-3)[1M]` | deef14d20570b450beae04d3ccf818e20634456a `clk-divider.c` | `Sebastian Reichel` _clk: divider: Fix divisor masking on 64 bit platforms_ |
| ✅  | `0010-fix-clk-divisions` | `(+2/-4)[1M]` | 293fa3bb3a642eda56c03a4f9c4c02fdb3c919c7 `clk-composite.c` | `Sebastian Reichel` _clk: composite: replace open-coded abs_diff()_ |
| ✅  | `0011-irqchip-fix-its-timeout-issue` | `(+72/-7)[1M]` | 8143a4c2ee34adf745e0a1ef93ef33ee5df2853c `irq-gic-v3-its.c` | `Muhammed Efe Cetin` _irqchip/irq-gic-v3-its: fix its timeout issue for rk35xx boards_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+148/-0)[1A]` | c35a6d52df73d0a89c083f9340bd9b2653cc065e `phy-rockchip-usbdp.yaml` | `Sebastian Reichel` _dt-bindings: phy: add rockchip usbdp combo phy document_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+1625/-0)[2M, 1A]` | 37f72fc24f7b35b010560fc0fa8a41ab15028099 `phy-rockchip-usbdp.c`, `Kconfig`, `Makefile` | `Sebastian Reichel` _phy: rockchip: add usbdp combo phy driver_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+1/-0)[1M]` | ebea23d0bba881b13116d8bfdbc66ad01c3c07be `defconfig` | `Sebastian Reichel` _arm64: defconfig: enable Rockchip Samsung USBDP PHY_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+2/-2)[1M]` | f963a3f0e667aafd514604678628f423b8075a8f `rk3588s.dtsi` | `Sebastian Reichel` _arm64: dts: rockchip: fix usb2phy nodename for rk3588_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+8/-8)[1M]` | b877ea1c91787cef2f71d48c64f8443dfd7006ac `rk3588s.dtsi` | `Sebastian Reichel` _arm64: dts: rockchip: reorder usb2phy properties for rk3588_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+115/-0)[2M]` | 34fba1b9b664b596c971615a97b6a137b8058298 `rk3588s.dtsi`, `rk3588.dtsi` | `Sebastian Reichel` _arm64: dts: rockchip: add USBDP phys on rk3588_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+42/-0)[2M]` | 0a0205588d8489abd6ea908966a031dd169a3543 `rk3588s.dtsi`, `rk3588.dtsi` | `Sebastian Reichel` _arm64: dts: rockchip: add USB3 DRD controllers on rk3588_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+143/-0)[1M]` | ae9361c3cee8121875bff27f32787eb60b66bd5e `rk3588-evb1-v10.dts` | `Sebastian Reichel` _arm64: dts: rockchip: add USB3 to rk3588-evb1_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+2/-2)[1M]` | 2aca0b7c4259be0fcf448343c49c3212b69a54b8 `tcpm.c` | `Sebastian Reichel` _usb: typec: tcpm: avoid graph warning_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+18/-0)[1M]` | 683a378a7f5584d291319699164a77b773e82307 `rk3588s-rock-5a.dts` | `Sebastian Reichel` _arm64: dts: rockchip: add upper USB3 port to rock-5a_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+17/-0)[1M]` | 8fb48ea1eb4ec5a07ebad9af5ff2dac5012d4b98 `rk3588-rock-5b.dts` | `Sebastian Reichel` _arm64: dts: rockchip: add lower USB3 port to rock-5b_ |
| ✅  | `0022-RK3588-Add-Cpufreq-Support` | `(+658/-0)[3M, 1A]` | 26b22c8fb5e3ab72addc27c851e1167b58877da3 `rockchip-cpufreq.c`, `Kconfig.arm`, `cpufreq-dt-platdev.c`, `Makefile` | `Sebastian Reichel` _cpufreq: rockchip: Introduce driver for rk3588_ |
| ✅  | `0022-RK3588-Add-Cpufreq-Support` | `(+452/-0)[1M]` | 18e31f719393f1918a7f32505674360d39867d53 `rk3588s.dtsi` | `Sebastian Reichel` _arm64: dts: rockchip: rk3588: add cpu frequency scaling support_ |
| ✅  | `0022-RK3588-Add-Cpufreq-Support` | `(+8/-0)[1M]` | aada55b27b72f72048965c19fa5ce888dd55733e `rk3588-evb1-v10.dts` | `Sebastian Reichel` _arm64: dts: rockchip: rk3588-evb1: add cpu mem regulator info_ |
| ✅  | `0022-RK3588-Add-Cpufreq-Support` | `(+8/-0)[1M]` | 92b966dae908705370cc0d8382a437b5f9baaf2a `rk3588s-rock-5a.dts` | `Sebastian Reichel` _arm64: dts: rockchip: rock5a: add cpu mem regulator info_ |
| ✅  | `0022-RK3588-Add-Cpufreq-Support` | `(+8/-0)[1M]` | fb14b93fcb499d0013fb1d2cdb450df0cfb6c55e `rk3588-rock-5b.dts` | `Sebastian Reichel` _arm64: dts: rockchip: rock5b: add cpu mem regulator info_ |
| ✅  | `0024-RK3588-Add-Crypto-Support` | `(+65/-0)[1A]` | c1641c9ee837035ecf49988f84d2cbcebb436361 `rockchip,rk3588-crypto.yaml` | `Corentin Labbe` _dt-bindings: crypto: add support for rockchip,crypto-rk3588_ |
| ✅  | `0024-RK3588-Add-Crypto-Support` | `(+12/-0)[1M]` | 38749acce553b641965624f4e6ad6ade911ac950 `rk3588s.dtsi` | `Corentin Labbe` _ARM64: dts: rk3588: add crypto node_ |
| ✅  | `0024-RK3588-Add-Crypto-Support` | `(+12/-0)[1M]` | 820b3d46d49451ec7e0115c9ba5ed0703420a581 `rk356x.dtsi` | `Corentin Labbe` _ARM64: dts: rk356x: add crypto node_ |
| ✅  | `0024-RK3588-Add-Crypto-Support` | `(+34/-76)[2M]` | 0bdcac91b40c90e3833c889ee44a734ec965455a `rockchip,rk3588-cru.h`, `rst-rk3588.c` | `Corentin Labbe` _reset: rockchip: secure reset must be used by SCMI_ |
| ✅  | `0024-RK3588-Add-Crypto-Support` | `(+1939/-0)[2M, 4A]` | ebe091d3eaab341e9010a728cd1b99d5e7f659e8 `rk2_crypto.c`, `rk2_crypto_skcipher.c`, `rk2_crypto_ahash.c`, `rk2_crypto.h`, `Kconfig`, `Makefile` | `Corentin Labbe` _crypto: rockchip: add rk3588 driver_ |
| ✅  | `0025-RK3588-Add-HW-RNG-Support` | `(+588/-0)[2M, 1A]` | 5f2505260e02ac37233039e90e8716f2ca9c4ed1 `rockchip-rng.c`, `Kconfig`, `Makefile` | `Muhammed Efe Cetin` _hwrng: rockchip: Add support for Rockchip HW RNG_ |
| ✅  | `0025-RK3588-Add-HW-RNG-Support` | `(+10/-0)[1M]` | 0f9d8d8a3b78ea3708d799af31f308c031333016 `rk3588s.dtsi` | `Muhammed Efe Cetin` _arm64: dts: Add HW RNG support to RK3588S_ |
| ✅  | `0026-Add-missing-nodes-to-Orange-Pi-5` | `(+214/-1)[1M]` | b58557e1ad39a91798ff534304e5a936577d4a2f `rk3588s-orangepi-5.dts` | `Muhammed Efe Cetin` _arm64: dts: Add missing nodes to Orange Pi 5_ |
| ✅  | `0027-arm64-dts-Add-missing-nodes-to-Orange-Pi-5-Plus` | `(+189/-1)[1M]` | d513e1083885e0ce5c7a35714dbc8fa02d825b77 `rk3588-orangepi-5-plus.dts` | `Muhammed Efe Cetin` _arm64: dts: Add missing nodes to Orange Pi 5 Plus_ |
| ✅  | `0028-Add-HDMI-QP-Support-for-RK3588` | `(+2355/-0)[2M, 1A]` | 91ba333fa0c56f6768656559726b07b966bf5406 `phy-rockchip-samsung-hdptx-hdmi.c`, `Kconfig`, `Makefile` | `Algea Cao` _phy/rockchip: Add the hdptx-hdmi driver_ |
| ✅  | `0028-Add-HDMI-QP-Support-for-RK3588` | `(+9148/-733)[10M, 7A]` | 1df4099bb09378d9756ede35f2945fc144d14d09 `dw_hdmi-rockchip.c`, `dw-hdmi-qp.c`, `dw-hdmi.c`, `dw-hdmi-qp.h`, `dw-hdmi-qp-cec.c`, `dw-hdmi-qp-i2s-audio.c`, `dw_hdmi.h`, `dw-hdmi.h`, `dw-hdmi-hdcp.h`, `dw-hdmi-qp-audio.h`, `dw-hdmi-qp-cec.h`, `Kconfig`, `dw-hdmi-i2s-audio.c`, `dw-hdmi-ahb-audio.c`, `dw-hdmi-cec.c`, _and 2 more_ | `Boris Brezillon` _drm/rockchip: dw hdmi qp support for rk3588_ |
| ✅  | `0029-Add-VOP2-Support-for-RK3588` | `(+73/-15)[1M]` | b7d0a49e188546f7fc35cc8c66cde3751340c268 `rockchip_drm_vop2.c` | `Andy Yan` _drm/rockchip: vop2: Add cursor plane support_ |
| ✅  | `0029-Add-VOP2-Support-for-RK3588` | `(+4/-1)[1M]` | e425615746b9e790be92b6697a577fcdd75d30f2 `rockchip_drm_vop2.c` | `Andy Yan` _drm/rockchip: vop2: A workaround for cursor plane zpos_ |
| ✅  | `0029-Add-VOP2-Support-for-RK3588` | `(+398/-0)[1M]` | 61ec7f9696a9848cf746d94da97b3560236a1b16 `rockchip_drm_vop2.c` | `Andy Yan` _drm/rockchip: vop2: Add debugfs support_ |
| ✅  | `0029-Add-VOP2-Support-for-RK3588` | `(+123/-0)[2M]` | bbe2203959e776382f44a9f02fdc1d7f3a05229f `rk3588s.dtsi`, `rk3588-evb1-v10.dts` | `Andy Yan` _arm64: dts: rockchip: Enable hdmi display on rk3588-evb1_ |
| ✅  | `0030-arm64-dts-rock-5b-Slow-down-emmc-to-hs200-and-add-ts` | `(+5/-2)[1M]` | 2812c7dbfb6584b8ae52e0805f2546c0c1e82021 `rk3588-rock-5b.dts` | `amazingfate` _arm64: dts: rock-5b: Slow down emmc to hs200 and add tsadc node_ |
| ✅  | `0031-Add-HDMI-and-VOP2-to-Rock-5A` | `(+48/-0)[1M]` | 1f86999349d2e745b497515dd80f4031b15ceb88 `rk3588s-rock-5a.dts` | `Muhammed Efe Cetin` _Add HDMI and VOP2 to Rock 5A_ |
| ✅  | `0032-Add-HDMI-and-VOP2-to-Rock-5B` | `(+48/-0)[1M]` | fa38b099f6bcd76b17941c28c5a5d2e87c021854 `rk3588-rock-5b.dts` | `Muhammed Efe Cetin` _Add HDMI and VOP2 to Rock 5B_ |
| ✅  | `0033-tools-Makefile-delete-missing-cgroup_clean` | `(+2/-2)[1M]` | b40144afc3ab6fde72402c47080a7cf451893860 `Makefile` | `amazingfate` _tools/Makefile: delete missing cgroup_clean_ |
| ✅  | `0034-arm64-dts-fix-rtc-add-poweroff-support-Orange-Pi-5-Plus` | `(+4/-2)[1M]` | 1f31131e16491ab6f3d8f0f13991dbfdf453e3c6 `rk3588-orangepi-5-plus.dts` | `John Doe` _Patching kernel rockchip-rk3588 files arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+81/-0)[1M]` | f9b3cfcdb6aacaac0a25fed6106819e88a31dd8c `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add cpu regulators and vcc5v0_sys to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+335/-0)[1M]` | 1e636836cd4703cd1dd49bd77a5950f149bd4b58 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add PMIC to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+34/-0)[1M]` | e4b72c78365a7514632c13bbdcfa2deba4b92fa9 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add TF card to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+97/-0)[1M]` | eb7d55d7d40e39251cbfbd1729a3bcad4116bd89 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: USB2, USB3 Host, PCIe2 to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+66/-0)[1M]` | 4da935a42d6342cbad5563901ff72ae1db016e54 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add ir receiver and leds to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+24/-0)[1M]` | ba0edbfd55e0640052ae6c2f038257b2ff999ce4 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add saradc and adc buttons to Khadas Edge 2 and enable tsadc_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+14/-0)[1M]` | 77a6e544f8f99373f19eca1ed68ea69ee8ee4ba2 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add SFC to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+20/-0)[1M]` | 6761588e4c0ab53ba0b833e693733c8cd59244d5 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add UART9 (bluetooth) to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+12/-0)[1M]` | b621821fef9f457bd7a9aab44d06525c829c5424 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add RTC to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+120/-0)[1M]` | 9c6355483a40222cda96e7979d3ad8fdb57bc35f `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add USB-C to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+9/-0)[1M]` | 5973a726e8c82b1eb4b3293154d43094432f7fc6 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add bluetooth rfkill to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+50/-0)[1M]` | 40c053c180bfecf84adffd93b30e5d6888995e56 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add HDMI & VOP2 to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+17/-0)[1M]` | 7090c5479e7e808171db5bd180d0a49553baa53b `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+10/-2)[1M]` | 93886fb1fdb34a2198a468ceb279655337916810 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add cpufreq support to Khadas Edge 2_ |
| ✅  | `board-rock-5b-arm64-dts-enable-spi-flash` | `(+27/-0)[1M]` | 863156d463668cbcb78b606e97c259a271c7e060 `rk3588-rock-5b.dts` | `lanefu` _rock-5b enable SPI flash in device tree arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts_ |
| ✅  | `general-add-overlay-support` | `(+22/-1)[2M]` | b20256d567f4ccc4445e554c1748f197066cefc6 `Makefile.lib`, `Makefile.dtbinst` | `zador-blood-stained` _add overlay support_ |
| ✅  | `wireless-add-bcm43752` | `(+6/-1)[2M]` | 36fe32c3df21c7ce0753c51592a9384276add616 `pcie.c`, `brcm_hw_ids.h` | `Ondrej Jirman` _net: wireless: brcmfmac: Add support for AP6275P_ |
| ✅  | `wireless-add-clk-property` | `(+10/-0)[1M]` | 555c9acb8cb6da8c6a49dec5962467c44c6ab4bb `pcie.c` | `Ondrej Jirman` _net: wireless: brcmfmac: Add optional 32k clock enable support_ |


