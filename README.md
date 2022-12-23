#### kernel patching: 5 total patches; 5 applied; 3 with problems; 3 not_mbox

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
| ⚠️`[not_mbox]`  | `001-scripts-fix-modpost` | `(+63/-90)[3M]` | e95ed8b69aa7abf4314c349fa4a3810de91b6c21 `modpost.c`, `modpost.h`, `sumversion.c` | `unifreq` _[ARCHEOLOGY] rockchip-rk3588-legacy: kernel patch up to 5.10.72 (#4195)_ |
| ⚠️`[not_mbox]`  | `003-fix-compile-error-for-usb-gadget-legacy-webcam` | `(+1/-0)[1M]` | 39544796c94b18747ad8baf0b66d85dc48f844d5 `webcam.c` | `unifreq` _[ARCHEOLOGY] rockchip-rk3588-legacy: kernel patch up to 5.10.72 (#4195)_ |
| ✅  | `2001-add-board-orangepi5` | `(+2045/-8)[3M, 7A]` | c06e89da53bc9c346d89008a5125df7ce64136ef `rk3588s-orangepi.dtsi`, `rk3588s-orangepi-5.dts`, `rk3588s-orangepi-5.dtsi`, `rk3588s-orangepi-5-camera2.dtsi`, `rk3588s-orangepi-5-camera3.dtsi`, `rk3588s-orangepi-5-camera1.dtsi`, `rk3588s-orangepi-5-lcd.dtsi`, `rk3588s.dtsi`, `rk3588s-pinctrl.dtsi`, `Makefile` | `Ricardo Pardini` _OrangePi5 Device Tree; extracted from Xunlong tree_ |
| ✅  | `2002-OrangePi5-Motorcomm-stuff-extracted-from-Xun` | `(+2156/-0)[2M, 3A]` | 8b5c93af14cacab8dc0728c7d0b7e4cc185d35d3 `motorcomm.c`, `yt8614-phy.h`, `motorcomm_phy.h`, `Kconfig`, `Makefile` | `Ricardo Pardini` _OrangePi5; dubious Motorcomm stuff extracted from Xunlong tree_ |
| ⚠️`[not_mbox]`  | `999-remove-chosen-bootargs-from-dtsi` | `(+3/-3)[1M]` | fb5415d7442285620b5a1e20f22d3676da2e294c `rk3588-linux.dtsi` | `Ricardo Pardini` _[ARCHEOLOGY] OPi5: `rockchip-rk3588-legacy`: add patch to remove chosen > bootargs from `rk3588-linux.dtsi`_ |


