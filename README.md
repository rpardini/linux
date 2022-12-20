#### kernel patching: 5 total patches; 5 applied; 3 with problems; 3 not_mbox

| Problems | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
| ⚠️`[not_mbox]`  | `001-scripts-fix-modpost` | `(+63/-90)[3M]` | 408df2e29a26edf4616092218fd4d2ea1303a478 `modpost.c`, `modpost.h`, `sumversion.c` | `unifreq` _[ARCHEOLOGY] rockchip-rk3588-legacy: kernel patch up to 5.10.72 (#4195)_ |
| ⚠️`[not_mbox]`  | `003-fix-compile-error-for-usb-gadget-legacy-webcam` | `(+1/-0)[1M]` | 9dfc74b42ac0a7500b923ceb1540355aada748c3 `webcam.c` | `unifreq` _[ARCHEOLOGY] rockchip-rk3588-legacy: kernel patch up to 5.10.72 (#4195)_ |
| ✅  | `2001-add-board-orangepi5` | `(+2045/-8)[3M, 7A]` | 21091faba38d025011c289a3d028f9c6c2bab82c `rk3588s-orangepi.dtsi`, `rk3588s-orangepi-5.dts`, `rk3588s-orangepi-5.dtsi`, `rk3588s-orangepi-5-camera2.dtsi`, `rk3588s-orangepi-5-camera3.dtsi`, `rk3588s-orangepi-5-camera1.dtsi`, `rk3588s-orangepi-5-lcd.dtsi`, `rk3588s.dtsi`, `rk3588s-pinctrl.dtsi`, `Makefile` | `Ricardo Pardini` _OrangePi5 Device Tree; extracted from Xunlong tree_ |
| ✅  | `2002-OrangePi5-Motorcomm-stuff-extracted-from-Xun` | `(+2156/-0)[2M, 3A]` | ea3d1a75760e08953832f01a84dce480a9ef1b87 `motorcomm.c`, `yt8614-phy.h`, `motorcomm_phy.h`, `Kconfig`, `Makefile` | `Ricardo Pardini` _OrangePi5; dubious Motorcomm stuff extracted from Xunlong tree_ |
| ⚠️`[not_mbox]`  | `999-remove-chosen-bootargs-from-dtsi` | `(+3/-3)[1M]` | a357ee67051bb6e3f125ab5a0128bc8bc33fc86d `rk3588-linux.dtsi` | `Ricardo Pardini` _[ARCHEOLOGY] OPi5: `rockchip-rk3588-legacy`: add patch to remove chosen > bootargs from `rk3588-linux.dtsi`_ |


