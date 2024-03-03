#### kernel patching: 59 total patches; 59 applied; 6 with problems; 6 needs_rebase

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
|  🤖  ✅  | `[kernel-drivers/]` `sha1_d206a76d7d2726f3b096037f2079ce0bd3ba329b_rockchip-rk3588_edge_7b5ee01d_2f99f672-01ba4719` | `(+0/-0)[]` | bcec685f0c344b2dc090a865dc78efc2f3114e2a `?` | `Armbian Autopatcher` _[AUTOGEN] /armbian/cache/patch/kernel-drivers/sha1_d206a76d7d2726f3b096037f2079ce0bd3ba329b_rockchip-rk3588_edge_7b5ee01d_2f99f672-01ba4719_ |
| ✅  | `0010-fix-clk-divisions` | `(+11/-0)[1M]` | 31d6a772accb2e3a9df2d8354049750305fca728 `math.h` | `Sebastian Reichel` _math.h: add DIV_ROUND_UP_NO_OVERFLOW_ |
| ✅  | `0010-fix-clk-divisions` | `(+3/-3)[1M]` | 6856e68a8f8ffa224a2872aa6ef19536ee6e6b57 `clk-divider.c` | `Sebastian Reichel` _clk: divider: Fix divisor masking on 64 bit platforms_ |
| ✅  | `0010-fix-clk-divisions` | `(+2/-4)[1M]` | 835dd1122df782352694dd770c67103773f57e81 `clk-composite.c` | `Sebastian Reichel` _clk: composite: replace open-coded abs_diff()_ |
| ⚠️`[needs_rebase]`  | `0011-irqchip-fix-its-timeout-issue` | `(+72/-7)[1M]` | 2b81c538c55ea7549fadb139f1d17d6b6d8ffa07 `irq-gic-v3-its.c` | `Muhammed Efe Cetin` _irqchip/irq-gic-v3-its: fix its timeout issue for rk35xx boards_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+148/-0)[1A]` | 224d2444c1bca12f2803756747ad13e8b087053e `phy-rockchip-usbdp.yaml` | `Sebastian Reichel` _dt-bindings: phy: add rockchip usbdp combo phy document_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+1625/-0)[2M, 1A]` | ab92ffe0b5dc247c174d3e91e4f0e2efba847588 `phy-rockchip-usbdp.c`, `Kconfig`, `Makefile` | `Sebastian Reichel` _phy: rockchip: add usbdp combo phy driver_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+1/-0)[1M]` | 3ad0ded85714e24b7067e305b9dd2c4bbfd5eddb `defconfig` | `Sebastian Reichel` _arm64: defconfig: enable Rockchip Samsung USBDP PHY_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+2/-2)[1M]` | f73f215f7723eef46926e901bc4d062971e5558e `rk3588s.dtsi` | `Sebastian Reichel` _arm64: dts: rockchip: fix usb2phy nodename for rk3588_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+8/-8)[1M]` | 860b74fad437669f4a5688f075c73bb473ba67b4 `rk3588s.dtsi` | `Sebastian Reichel` _arm64: dts: rockchip: reorder usb2phy properties for rk3588_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+115/-0)[2M]` | 5ccab1b26e442c8c02fe470f0bcd39901444b138 `rk3588s.dtsi`, `rk3588.dtsi` | `Sebastian Reichel` _arm64: dts: rockchip: add USBDP phys on rk3588_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+42/-0)[2M]` | accf8a845a8b821a6863435c2896f6ee276fdd9b `rk3588s.dtsi`, `rk3588.dtsi` | `Sebastian Reichel` _arm64: dts: rockchip: add USB3 DRD controllers on rk3588_ |
| ⚠️`[needs_rebase]`  | `0021-RK3588-Add-USB3-DRD-Support` | `(+143/-0)[1M]` | 322f974857645917fae3ce8459548e946cdd5c0a `rk3588-evb1-v10.dts` | `Sebastian Reichel` _arm64: dts: rockchip: add USB3 to rk3588-evb1_ |
| ⚠️`[needs_rebase]`  | `0021-RK3588-Add-USB3-DRD-Support` | `(+2/-2)[1M]` | 173463ad54ceea1863c4756059dbb085ce8b8e0d `tcpm.c` | `Sebastian Reichel` _usb: typec: tcpm: avoid graph warning_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+18/-0)[1M]` | 886ce016ddf4fe94720b2756ae5dbeee492f37ca `rk3588s-rock-5a.dts` | `Sebastian Reichel` _arm64: dts: rockchip: add upper USB3 port to rock-5a_ |
| ✅  | `0021-RK3588-Add-USB3-DRD-Support` | `(+17/-0)[1M]` | d8c2624b373add5f3d694a2d7bd9a29801b0c5d2 `rk3588-rock-5b.dts` | `Sebastian Reichel` _arm64: dts: rockchip: add lower USB3 port to rock-5b_ |
| ✅  | `0022-RK3588-Add-Cpufreq-Support` | `(+658/-0)[3M, 1A]` | 3d26dedf8f3af634f45feaf57ca6040b41018689 `rockchip-cpufreq.c`, `Kconfig.arm`, `cpufreq-dt-platdev.c`, `Makefile` | `Sebastian Reichel` _cpufreq: rockchip: Introduce driver for rk3588_ |
| ✅  | `0022-RK3588-Add-Cpufreq-Support` | `(+452/-0)[1M]` | d8654e0fd68a2abb75d3b03f7a3d2e5f38e45c2d `rk3588s.dtsi` | `Sebastian Reichel` _arm64: dts: rockchip: rk3588: add cpu frequency scaling support_ |
| ✅  | `0022-RK3588-Add-Cpufreq-Support` | `(+8/-0)[1M]` | 057e8f8d0aec51a0a6ca016e8cba2e67f570e2e1 `rk3588-evb1-v10.dts` | `Sebastian Reichel` _arm64: dts: rockchip: rk3588-evb1: add cpu mem regulator info_ |
| ✅  | `0022-RK3588-Add-Cpufreq-Support` | `(+8/-0)[1M]` | 219bed0dcf4c6c235e1b0c0e10a5c8cf0577e2f8 `rk3588s-rock-5a.dts` | `Sebastian Reichel` _arm64: dts: rockchip: rock5a: add cpu mem regulator info_ |
| ✅  | `0022-RK3588-Add-Cpufreq-Support` | `(+8/-0)[1M]` | bd58fbceba7e30edc9a6103acdb6bc420f4ef4a0 `rk3588-rock-5b.dts` | `Sebastian Reichel` _arm64: dts: rockchip: rock5b: add cpu mem regulator info_ |
| ✅  | `0024-RK3588-Add-Crypto-Support` | `(+65/-0)[1A]` | 53c003e8361db9c79a44dc57d3939bfa0a6ff419 `rockchip,rk3588-crypto.yaml` | `Corentin Labbe` _dt-bindings: crypto: add support for rockchip,crypto-rk3588_ |
| ✅  | `0024-RK3588-Add-Crypto-Support` | `(+12/-0)[1M]` | 4b93e46f60001042bae0b153fa15d937da5f2dc7 `rk3588s.dtsi` | `Corentin Labbe` _ARM64: dts: rk3588: add crypto node_ |
| ✅  | `0024-RK3588-Add-Crypto-Support` | `(+12/-0)[1M]` | e4e2ace93a68d55c507888b9fe0bd77074234513 `rk356x.dtsi` | `Corentin Labbe` _ARM64: dts: rk356x: add crypto node_ |
| ✅  | `0024-RK3588-Add-Crypto-Support` | `(+34/-76)[2M]` | a7332d2d48850c1d38c46bb201896dfde3403171 `rockchip,rk3588-cru.h`, `rst-rk3588.c` | `Corentin Labbe` _reset: rockchip: secure reset must be used by SCMI_ |
| ✅  | `0024-RK3588-Add-Crypto-Support` | `(+1939/-0)[2M, 4A]` | 003824de9f212a9283d5e43f05ac9f9bfebdf07b `rk2_crypto.c`, `rk2_crypto_skcipher.c`, `rk2_crypto_ahash.c`, `rk2_crypto.h`, `Kconfig`, `Makefile` | `Corentin Labbe` _crypto: rockchip: add rk3588 driver_ |
| ✅  | `0025-RK3588-Add-HW-RNG-Support` | `(+588/-0)[2M, 1A]` | 57f61de3f9297934615dae1e177179296b230084 `rockchip-rng.c`, `Kconfig`, `Makefile` | `Muhammed Efe Cetin` _hwrng: rockchip: Add support for Rockchip HW RNG_ |
| ✅  | `0025-RK3588-Add-HW-RNG-Support` | `(+10/-0)[1M]` | 0f7a1237f85802ece5a1b089845e1a8993d2b0d7 `rk3588s.dtsi` | `Muhammed Efe Cetin` _arm64: dts: Add HW RNG support to RK3588S_ |
| ✅  | `0026-Add-missing-nodes-to-Orange-Pi-5` | `(+214/-1)[1M]` | f97b365858eda5a486aa4d463b442c559070bc46 `rk3588s-orangepi-5.dts` | `Muhammed Efe Cetin` _arm64: dts: Add missing nodes to Orange Pi 5_ |
| ✅  | `0027-arm64-dts-Add-missing-nodes-to-Orange-Pi-5-Plus` | `(+189/-1)[1M]` | ae7b288c1967013810b4aafb30a22b500b740124 `rk3588-orangepi-5-plus.dts` | `Muhammed Efe Cetin` _arm64: dts: Add missing nodes to Orange Pi 5 Plus_ |
| ✅  | `0028-Add-HDMI-QP-Support-for-RK3588` | `(+2355/-0)[2M, 1A]` | 9ef4ea095b6a93c3549fe3bbd74122f90413895c `phy-rockchip-samsung-hdptx-hdmi.c`, `Kconfig`, `Makefile` | `Algea Cao` _phy/rockchip: Add the hdptx-hdmi driver_ |
| ✅  | `0028-Add-HDMI-QP-Support-for-RK3588` | `(+9148/-733)[10M, 7A]` | aa50189cc5f9e98204d21cfa3cb94c559a222f7d `dw_hdmi-rockchip.c`, `dw-hdmi-qp.c`, `dw-hdmi.c`, `dw-hdmi-qp.h`, `dw-hdmi-qp-cec.c`, `dw-hdmi-qp-i2s-audio.c`, `dw_hdmi.h`, `dw-hdmi.h`, `dw-hdmi-hdcp.h`, `dw-hdmi-qp-audio.h`, `dw-hdmi-qp-cec.h`, `Kconfig`, `dw-hdmi-i2s-audio.c`, `dw-hdmi-ahb-audio.c`, `dw-hdmi-cec.c`, _and 2 more_ | `Boris Brezillon` _drm/rockchip: dw hdmi qp support for rk3588_ |
| ⚠️`[needs_rebase]`  | `0029-Add-VOP2-Support-for-RK3588` | `(+73/-15)[1M]` | 380245710232293e8f2b594fe91b55e0bbbaf2c3 `rockchip_drm_vop2.c` | `Andy Yan` _drm/rockchip: vop2: Add cursor plane support_ |
| ⚠️`[needs_rebase]`  | `0029-Add-VOP2-Support-for-RK3588` | `(+4/-1)[1M]` | 5fb02b5cc72565eb69bd2f5ee26f16ca56f94447 `rockchip_drm_vop2.c` | `Andy Yan` _drm/rockchip: vop2: A workaround for cursor plane zpos_ |
| ⚠️`[needs_rebase]`  | `0029-Add-VOP2-Support-for-RK3588` | `(+398/-0)[1M]` | 08cb0fabde8cc66bffd0c11496077fb0be02b828 `rockchip_drm_vop2.c` | `Andy Yan` _drm/rockchip: vop2: Add debugfs support_ |
| ✅  | `0029-Add-VOP2-Support-for-RK3588` | `(+123/-0)[2M]` | 8b6000e44021d56fce5517f563dd2327e4acdc42 `rk3588s.dtsi`, `rk3588-evb1-v10.dts` | `Andy Yan` _arm64: dts: rockchip: Enable hdmi display on rk3588-evb1_ |
| ✅  | `0030-arm64-dts-rock-5b-Slow-down-emmc-to-hs200-and-add-ts` | `(+5/-2)[1M]` | c0f1f57814d9b8315e5c9782329ae11f68adaf46 `rk3588-rock-5b.dts` | `amazingfate` _arm64: dts: rock-5b: Slow down emmc to hs200 and add tsadc node_ |
| ✅  | `0031-Add-HDMI-and-VOP2-to-Rock-5A` | `(+48/-0)[1M]` | c8b0b6e4e519ac325b544875afa9bec4361d4186 `rk3588s-rock-5a.dts` | `Muhammed Efe Cetin` _Add HDMI and VOP2 to Rock 5A_ |
| ✅  | `0032-Add-HDMI-and-VOP2-to-Rock-5B` | `(+48/-0)[1M]` | 30353d8bfb8156c278fefa099079f96c1d8990d3 `rk3588-rock-5b.dts` | `Muhammed Efe Cetin` _Add HDMI and VOP2 to Rock 5B_ |
| ✅  | `0033-tools-Makefile-delete-missing-cgroup_clean` | `(+2/-2)[1M]` | 7afb4328debea90e698170b2444f07aa08f1fd64 `Makefile` | `amazingfate` _tools/Makefile: delete missing cgroup_clean_ |
| ✅  | `0034-arm64-dts-fix-rtc-add-poweroff-support-Orange-Pi-5-Plus` | `(+4/-2)[1M]` | 3e15680fe02e85e9d06a0cc4efc886ae8509ba0a `rk3588-orangepi-5-plus.dts` | `John Doe` _Patching kernel rockchip-rk3588 files arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+81/-0)[1M]` | b19eb2f4d2303ac538b8a0dc56c7735f329de3ea `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add cpu regulators and vcc5v0_sys to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+335/-0)[1M]` | d532472976232cd35bb08a34906b452556acdaba `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add PMIC to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+34/-0)[1M]` | 0eaf9732fd18ebb6425cfd932c91876dfc45d36b `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add TF card to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+97/-0)[1M]` | 6dbfded16adac017458a20298c1473044a32c4ec `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: USB2, USB3 Host, PCIe2 to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+66/-0)[1M]` | 4ceef71d06566b7a16d182146832287e6d79f110 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add ir receiver and leds to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+24/-0)[1M]` | 3968d0d05c21aceb6c3c91154ae4497c9cb2d5f5 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add saradc and adc buttons to Khadas Edge 2 and enable tsadc_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+14/-0)[1M]` | d9ce3551016a1e5caa9f10ab0c4e3681e79da09a `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add SFC to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+20/-0)[1M]` | 4c8042d535376b76a8132fb44dd11e7c4164da5d `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add UART9 (bluetooth) to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+12/-0)[1M]` | 2464566798b78138f4a7cb73bdedb5bee2f7d8b9 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add RTC to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+120/-0)[1M]` | 4752d7f703f81336d0dc57b6e359ffad3db778d4 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add USB-C to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+9/-0)[1M]` | 07664121a9b62f61d7d0d4f209b6621e1530bb56 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add bluetooth rfkill to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+50/-0)[1M]` | f5b5c10bce1c6c7956a5fc70526096c89eead762 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add HDMI & VOP2 to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+17/-0)[1M]` | e4c299e721cd4b2ee3ac50757c2c7851d30c9007 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2_ |
| ✅  | `board-khadas-edge2-add-nodes` | `(+10/-2)[1M]` | b4728afe4263f8007c8f815e4fd04a7ef5038d61 `rk3588s-khadas-edge2.dts` | `Muhammed Efe Cetin` _arm64: dts: rockchip: Add cpufreq support to Khadas Edge 2_ |
| ✅  | `board-rock-5b-arm64-dts-enable-spi-flash` | `(+27/-0)[1M]` | a6d788a8252095e861b4ddfca3c09ed585532b1b `rk3588-rock-5b.dts` | `lanefu` _rock-5b enable SPI flash in device tree arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts_ |
| ✅  | `general-add-overlay-support` | `(+22/-1)[2M]` | ddc4797d3ad865d3423f82f733540d86171de217 `Makefile.lib`, `Makefile.dtbinst` | `zador-blood-stained` _add overlay support_ |
| ✅  | `wireless-add-bcm43752` | `(+6/-1)[2M]` | e580fc21421a62973d3740de5076314aa3126367 `pcie.c`, `brcm_hw_ids.h` | `Ondrej Jirman` _net: wireless: brcmfmac: Add support for AP6275P_ |
| ✅  | `wireless-add-clk-property` | `(+10/-0)[1M]` | c7820cad087f6e671c87adfe4b20da11a6f4e2b4 `pcie.c` | `Ondrej Jirman` _net: wireless: brcmfmac: Add optional 32k clock enable support_ |


