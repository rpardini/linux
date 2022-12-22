#### kernel patching: 5 total patches; 5 applied; 3 with problems; 3 not_mbox

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
| ⚠️`[not_mbox]`  | `001-scripts-fix-modpost` | `(+63/-90)[3M]` | 2232533a89db4df917e23972226dc48210fd9fe2 `modpost.c`, `modpost.h`, `sumversion.c` | `unifreq` _[ARCHEOLOGY] rockchip-rk3588-legacy: kernel patch up to 5.10.72 (#4195)_ |
| ⚠️`[not_mbox]`  | `003-fix-compile-error-for-usb-gadget-legacy-webcam` | `(+1/-0)[1M]` | cae77d79b7afce44596669516ff8bd6271c60f62 `webcam.c` | `unifreq` _[ARCHEOLOGY] rockchip-rk3588-legacy: kernel patch up to 5.10.72 (#4195)_ |
| ✅  | `2001-add-board-orangepi5` | `(+2045/-8)[3M, 7A]` | a0ee677c08e5853d27116050124c378d0466efa5 `rk3588s-orangepi.dtsi`, `rk3588s-orangepi-5.dts`, `rk3588s-orangepi-5.dtsi`, `rk3588s-orangepi-5-camera2.dtsi`, `rk3588s-orangepi-5-camera3.dtsi`, `rk3588s-orangepi-5-camera1.dtsi`, `rk3588s-orangepi-5-lcd.dtsi`, `rk3588s.dtsi`, `rk3588s-pinctrl.dtsi`, `Makefile` | `Ricardo Pardini` _OrangePi5 Device Tree; extracted from Xunlong tree_ |
| ✅  | `2002-OrangePi5-Motorcomm-stuff-extracted-from-Xun` | `(+2156/-0)[2M, 3A]` | db6ab48137c8934c6d34fd6f834c0461b74ca27f `motorcomm.c`, `yt8614-phy.h`, `motorcomm_phy.h`, `Kconfig`, `Makefile` | `Ricardo Pardini` _OrangePi5; dubious Motorcomm stuff extracted from Xunlong tree_ |
| ⚠️`[not_mbox]`  | `999-remove-chosen-bootargs-from-dtsi` | `(+3/-3)[1M]` | a7cce2d28e85bfb61793810285b136e748738ce2 `rk3588-linux.dtsi` | `Ricardo Pardini` _[ARCHEOLOGY] OPi5: `rockchip-rk3588-legacy`: add patch to remove chosen > bootargs from `rk3588-linux.dtsi`_ |


