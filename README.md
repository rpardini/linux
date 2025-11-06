#### kernel patching: 59 total patches; 58 applied; 1 with problems; 1 needs_rebase; 1 failed_apply

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
|  🤖  ✅  | `[kernel-drivers/]` `sha1_8a243ecde1f6447b8e237f2c1c67c0bb67d16d67_x86_current_eeeab8a5_d15788c1-01ba4719` | `(+0/-0)[]` | e091b4b0fb6214e0c9fa1b1099348d6c839f5ce4 `?` | `Armbian Autopatcher` _[AUTOGEN] /armbian/cache/patch/kernel-drivers/sha1_8a243ecde1f6447b8e237f2c1c67c0bb67d16d67_x86_current_eeeab8a5_d15788c1-01ba4719_ |
| ✅  | `1001-Add-apple-bce-driver` | `(+5639/-0)[25A]` | abfc6d901557c6af14a71836c0abf89717234706 `vhci.c`, `audio.c`, `transfer.c`, `apple_bce.c`, `protocol.c`, `pcm.c`, `queue.c`, `protocol_bce.c`, `queue_dma.c`, `command.h`, `mailbox.c`, `protocol.h`, `audio.h`, `queue.h`, `transfer.h`, _and 8 more_ | `Aditya Garg` _Add apple-bce driver_ |
| ⚠️`[needs_rebase]`  ❌`[failed_apply]`  | `1002-Put-apple-bce-in-drivers-staging` | `(+22/-1)[3M, 1A]` | `Kconfig`, `Makefile` | `Redecorating` _Put apple-bce in drivers/staging_ |
| ✅  | `1003-Fix-sparse-errors` | `(+5/-2)[1M]` | 269f6b02f6b481fa405ac03eecbfaa02a18f0400 `apple_bce.h` | `Aditya Garg` _Fix sparse errors_ |
| ✅  | `1004-Fix-freezing-on-turning-off-camera` | `(+17/-3)[2M]` | 96cc6842d53f1ca3eb9fdd74c55ebdd0eaf9f5ae `transfer.c`, `transfer.h` | `mnural` _Fix freezing on turning off camera_ |
| ✅  | `1005-HID-hid-appletb-bl-add-driver-for-the-backlight-of-A` | `(+218/-1)[3M, 1A]` | 4d242e37b4f01527baf0850f392e2af84a79831f `hid-appletb-bl.c`, `Kconfig`, `hid-quirks.c`, `Makefile` | `Kerem Karabay` _HID: hid-appletb-bl: add driver for the backlight of Apple Touch Bars_ |
| ✅  | `1006-HID-hid-appletb-kbd-add-driver-for-the-keyboard-mode` | `(+539/-1)[3M, 2A]` | 821ef533ead149354a883272be48108950618798 `hid-appletb-kbd.c`, `Kconfig`, `sysfs-driver-hid-appletb-kbd`, `hid-quirks.c`, `Makefile` | `Kerem Karabay` _HID: hid-appletb-kbd: add driver for the keyboard mode of Apple Touch Bars_ |
| ✅  | `1007-HID-multitouch-Get-the-contact-ID-from-HID_DG_TRANSD` | `(+15/-1)[1M]` | a294fa0cfbad3ee34792e3a614d51c0e9761cb99 `hid-multitouch.c` | `Kerem Karabay` _HID: multitouch: Get the contact ID from HID_DG_TRANSDUCER_INDEX fields in case of Apple Touch Bar_ |
| ✅  | `1008-HID-multitouch-support-getting-the-tip-state-from-HI` | `(+11/-4)[1M]` | 5a15d24dacf716ab78481cbc1fe0c72cf75c7043 `hid-multitouch.c` | `Kerem Karabay` _HID: multitouch: support getting the tip state from HID_DG_TOUCH fields in Apple Touch Bar_ |
| ✅  | `1009-HID-multitouch-take-cls-maxcontacts-into-account-for` | `(+7/-0)[1M]` | 4a8298793817995c6b5dcdde88bbeb963c9c4da4 `hid-multitouch.c` | `Kerem Karabay` _HID: multitouch: take cls->maxcontacts into account for Apple Touch Bar even without a HID_DG_CONTACTMAX field_ |
| ✅  | `1010-HID-multitouch-specify-that-Apple-Touch-Bar-is-direc` | `(+7/-0)[1M]` | 065c98a76955374997c7597625861bf1aa0a855b `hid-multitouch.c` | `Kerem Karabay` _HID: multitouch: specify that Apple Touch Bar is direct_ |
| ✅  | `1011-HID-multitouch-add-device-ID-for-Apple-Touch-Bar` | `(+18/-0)[2M]` | 1337fbfe80b690a0b06294fba464d84152f5bdef `hid-multitouch.c`, `Kconfig` | `Kerem Karabay` _HID: multitouch: add device ID for Apple Touch Bar_ |
| ✅  | `1013-lib-vsprintf-Add-support-for-generic-FourCCs-by-exte` | `(+67/-7)[3M]` | 86c088e5c1999b0299bbfef176175eabe319ce14 `vsprintf.c`, `printk-formats.rst`, `checkpatch.pl` | `Hector Martin` _lib/vsprintf: Add support for generic FourCCs by extending %p4cc_ |
| ✅  | `1015-drm-tiny-add-driver-for-Apple-Touch-Bars-in-x86-Macs` | `(+861/-0)[3M, 1A]` | 68ea7f1bde4391d429ef0c7f64bce4dc9fb67754 `appletbdrm.c`, `Kconfig`, `MAINTAINERS`, `Makefile` | `Kerem Karabay` _drm/tiny: add driver for Apple Touch Bars in x86 Macs_ |
| ✅  | `2008-i915-4-lane-quirk-for-mbp15-1` | `(+20/-0)[3M]` | d62a2920747530dfc69f48255e4ef5caa139ddde `intel_quirks.c`, `intel_ddi.c`, `intel_quirks.h` | `Orlando Chamberlain` _i915: 4 lane quirk for mbp15,1_ |
| ✅  | `2009-apple-gmux-allow-switching-to-igpu-at-probe` | `(+23/-6)[4M]` | 0447664dc18bf15581413a981883d14ea3dddefa `apple-gmux.c`, `vga_switcheroo.c`, `amdgpu_drv.c`, `vgaarb.c` | `Orlando Chamberlain` _apple-gmux: allow switching to igpu at probe_ |
| ✅  | `3001-applesmc-convert-static-structures-to-drvdata` | `(+319/-221)[1M]` | df136ec4a3c9926f41809be9197f4a6d152ccbd2 `applesmc.c` | `Paul Pawlowski` _applesmc: convert static structures to drvdata_ |
| ✅  | `3002-applesmc-make-io-port-base-addr-dynamic` | `(+49/-42)[1M]` | 8b7819dc599cad76f1ffc89d4d88587ef7e1bbea `applesmc.c` | `Paul Pawlowski` _applesmc: make io port base addr dynamic_ |
| ✅  | `3003-applesmc-switch-to-acpi_device-from-platform` | `(+84/-40)[1M]` | 39df6f8e8f54a24d74a8ada436ff826c687068e3 `applesmc.c` | `Paul Pawlowski` _applesmc: switch to acpi_device (from platform)_ |
| ✅  | `3004-applesmc-key-interface-wrappers` | `(+79/-40)[1M]` | 3666da902baad94998b6dacd47c596394ff61b98 `applesmc.c` | `Paul Pawlowski` _applesmc: key interface wrappers_ |
| ✅  | `3005-applesmc-basic-mmio-interface-implementation` | `(+231/-6)[1M]` | c821cdfd385ade3d6ca1a4f211957b3f7aab106e `applesmc.c` | `Aun-Ali Zaidi` _applesmc: basic mmio interface implementation_ |
| ✅  | `3006-applesmc-fan-support-on-T2-Macs` | `(+102/-17)[1M]` | dfb82f3d095f8e7565bf558ae69097183c9d8a69 `applesmc.c` | `Paul Pawlowski` _applesmc: fan support on T2 Macs_ |
| ✅  | `3007-applesmc-Add-iMacPro-to-applesmc_whitelist` | `(+4/-0)[1M]` | e012bf7b88500b095ef03f90ac90136fc6d1827c `applesmc.c` | `Orlando Chamberlain` _applesmc: Add iMacPro to applesmc_whitelist_ |
| ✅  | `3008-applesmc-make-applesmc_remove-void` | `(+2/-2)[1M]` | 66b936eae3e809ccf7b347580e50391099a4ad8d `applesmc.c` | `Orlando Chamberlain` _applesmc: make applesmc_remove void_ |
| ✅  | `3009-applesmc-battery-charge-limiter` | `(+41/-1)[1M]` | 7654d0c5e1cdb2f6f6872ea9ae6d6229278f0205 `applesmc.c` | `Orlando Chamberlain` _applesmc: battery charge limiter_ |
| ✅  | `4001-asahi-trackpad` | `(+3/-3)[3M]` | 830fe3e5ae617e61d1e5437f2ec721c094e9e86d `apple.c`, `rtkit.c`, `rtkit.h` | `Asahi Lina` _soc: apple: rtkit: Pass the crashlog to the crashed() callback_ |
| ✅  | `4001-asahi-trackpad` | `(+13/-1)[3M]` | ea984946c7236a7f5fad44eb9a37c06a8319df83 `hid.h`, `hid-ids.h`, `hid-core.c` | `Janne Grunau` _HID: add device IDs for Apple SPI HID devices_ |
| ✅  | `4001-asahi-trackpad` | `(+7/-1)[2M]` | ecd5a1dc46b05cd4ab458659820688e3e1cd3b5c `hid-apple.c`, `Kconfig` | `Janne Grunau` _HID: apple: add support for internal keyboards_ |
| ✅  | `4001-asahi-trackpad` | `(+25/-0)[1M]` | 4874f58cd3b92df12b2dcb18e785061bdf1a9b00 `hid-apple.c` | `Janne Grunau` _HID: apple: add Fn key mapping for Apple silicon MacBooks_ |
| ✅  | `4001-asahi-trackpad` | `(+26/-0)[1M]` | 2a1944ff42280efa07c33dc904041927f359d882 `hid-apple.c` | `Janne Grunau` _HID: apple: add Fn key mapping for Macbook Pro with touchbar_ |
| ✅  | `4001-asahi-trackpad` | `(+5/-3)[1M]` | 322051a6c710487d0549dc67a3880466f67a62ea `hid-magicmouse.c` | `Janne Grunau` _HID: magicmouse: use a define of the max number of touch contacts_ |
| ✅  | `4001-asahi-trackpad` | `(+5/-5)[1M]` | 7aebdde147282f83224a6387da4170a7d9e3d588 `hid-magicmouse.c` | `Janne Grunau` _HID: magicmouse: use struct input_mt_pos for X/Y_ |
| ✅  | `4001-asahi-trackpad` | `(+31/-1)[1M]` | 9289c7b8bab23f8f554035cbbaf5a60f912b3df0 `hid-magicmouse.c` | `Janne Grunau` _HID: magicmouse: use ops function pointers for input functionality_ |
| ✅  | `4001-asahi-trackpad` | `(+260/-3)[2M]` | fa96bce414e3c6febd12bbfdb217271a59ea67d2 `hid-magicmouse.c`, `Kconfig` | `Janne Grunau` _HID: magicmouse: add support for Macbook trackpads_ |
| ✅  | `4001-asahi-trackpad` | `(+1240/-0)[2M, 5A]` | 06c41f20b488ad853bc4ce52875e6e8a9bf1fd90 `spi-hid-apple-core.c`, `spi-hid-apple-of.c`, `spi-hid-apple.h`, `Kconfig`, `Makefile` | `Janne Grunau` _WIP: HID: transport: spi: add Apple SPI transport_ |
| ✅  | `4001-asahi-trackpad` | `(+3/-0)[1M]` | 4415a9f91892fb65d358a09a608f09f9865533c0 `hid-ids.h` | `Hector Martin` _HID: add HOST vendor/device IDs for Apple MTP devices_ |
| ✅  | `4001-asahi-trackpad` | `(+3/-0)[1M]` | 6ee81495190c9d495ab13370beff3978580be52e `hid-core.c` | `Hector Martin` _HID: core: Handle HOST bus type when announcing devices_ |
| ✅  | `4001-asahi-trackpad` | `(+13/-6)[1M]` | 3739fea7afa9062a57879857dc5a6df1dc5b9ae8 `hid-apple.c` | `Hector Martin` _hid: apple: Bind to HOST devices for MTP_ |
| ✅  | `4001-asahi-trackpad` | `(+49/-18)[1M]` | 2fd419f0146f365c3cc275353ecf79489feffafb `hid-magicmouse.c` | `Hector Martin` _hid: magicmouse: Add MTP multi-touch device support_ |
| ✅  | `4001-asahi-trackpad` | `(+445/-0)[2M, 2A]` | 729c591b350ebb5fc40f4fb8f66b95c83fb79ea0 `dockchannel.c`, `dockchannel.h`, `Kconfig`, `Makefile` | `Hector Martin` _soc: apple: Add DockChannel driver_ |
| ✅  | `4001-asahi-trackpad` | `(+1237/-0)[2M, 3A]` | 5807fdb892392485b1fdb3e6e8109f106b6b85c7 `dockchannel-hid.c`, `Kconfig`, `Makefile` | `Hector Martin` _hid: Add Apple DockChannel HID transport driver_ |
| ✅  | `4001-asahi-trackpad` | `(+168/-0)[2M, 1A]` | 4aefca3ecbb7ec56d95ab7527400c29b38ec88d8 `rtkit-helper.c`, `Kconfig`, `Makefile` | `Hector Martin` _soc: apple: Add RTKit helper driver_ |
| ✅  | `4001-asahi-trackpad` | `(+10/-0)[1M]` | af93a8e2e50f217f6ecee3a5a1b4a28957dcb9e1 `spi-hid-apple-core.c` | `Janne Grunau` _HID: transport: spi: Check status message after transmits_ |
| ✅  | `4001-asahi-trackpad` | `(+14/-0)[1M]` | 00573fcc4b10826c2821817548f010efae285a28 `hid-magicmouse.c` | `Janne Grunau` _HID: magicmouse: Add .reset_resume for SPI trackpads_ |
| ✅  | `4001-asahi-trackpad` | `(+110/-2)[3M]` | 44d4a1782a3bcee3cf59664a5bd283e095c6bac3 `spi-hid-apple-core.c`, `spi-hid-apple-of.c`, `spi-hid-apple.h` | `Janne Grunau` _HID: transport: spi: Add suspend support_ |
| ✅  | `4001-asahi-trackpad` | `(+4/-1)[1M]` | decd2ce0d88b576b6a4e9c530e5155eb73623439 `hid-core.c` | `Hector Martin` _HID: Bump maximum report size to 16384_ |
| ✅  | `4001-asahi-trackpad` | `(+134/-71)[1M]` | f4f7064994592d5185f95128342558d213e38097 `hid-magicmouse.c` | `Hector Martin` _HID: magicmouse: Handle touch controller resets on SPI devices_ |
| ✅  | `4001-asahi-trackpad` | `(+48/-3)[1M]` | ba6882acb96e5d4ac98dbc74ce42b7845f3d7a60 `spi-hid-apple-core.c` | `Hector Martin` _HID: transport: spi: Implement GET FEATURE_ |
| ✅  | `4001-asahi-trackpad` | `(+81/-21)[1M]` | a4da6d076ba384b15f64c99b1a1605a70a6d6432 `hid-magicmouse.c` | `Hector Martin` _HID: magicmouse: Query device dimensions via HID report_ |
| ✅  | `4001-asahi-trackpad` | `(+9/-2)[1M]` | 9f860fe12d0e20d9b49836ea78695701172faa97 `spi-hid-apple-core.c` | `Janne Grunau` _HID: transport: spi: apple: Increase receive buffer size_ |
| ✅  | `4001-asahi-trackpad` | `(+11/-1)[1M]` | 0316610e43946b01db8929a205f240e613ee2fbb `spi-hid-apple-core.c` | `Janne Grunau` _HID: transport: spi: apple: Use distinctive names input devices_ |
| ✅  | `4002-HID-quirks-remove-T2-devices-from-hid_mouse_ignore_l` | `(+0/-8)[1M]` | e132c74cbd57997337d06c6872b2cb4dcf950d44 `hid-quirks.c` | `Aditya Garg` _HID: quirks: remove T2 devices from hid_mouse_ignore_list_ |
| ✅  | `4003-HID-apple-ignore-the-trackpad-on-T2-Macs` | `(+15/-8)[1M]` | cb0880b12b343a453e4960f633721cdfda00112f `hid-apple.c` | `Aditya Garg` _HID: apple: ignore the trackpad on T2 Macs_ |
| ✅  | `4004-HID-magicmouse-Add-support-for-trackpads-found-on-T2` | `(+313/-58)[1M]` | 43138b59a9093bf65e6d91b27504c75d26690c4c `hid-magicmouse.c` | `Aditya Garg` _HID: magicmouse: Add support for trackpads found on T2 Macs_ |
| ✅  | `4005-HID-apple-Add-necessary-IDs-and-support-for-replacem` | `(+14/-8)[3M]` | 879cba72bddd7574a40554c63650bae7d36e4bc1 `hid-ids.h`, `hid-apple.c`, `hid-quirks.c` | `Aditya Garg` _HID: apple: Add necessary IDs and support for replacement trackpad on MacBookPro15,1_ |
| ✅  | `4006-HID-magicmouse-Add-MacBookPro15-1-replacement-trackp` | `(+18/-0)[1M]` | 8b11c2c798a536f248ab8e9c8be756b3061ab1f3 `hid-magicmouse.c` | `Aditya Garg` _HID: magicmouse: Add MacBookPro15,1 replacement trackpad support_ |
| ✅  | `7001-drm-i915-fbdev-Discard-BIOS-framebuffers-exceeding-h` | `(+3/-3)[1M]` | 0615f05cbde765f6e19bdf9d707fbc474ef46494 `intel_fbdev.c` | `Ashish Arora` _drm/i915: Discard large BIOS framebuffers causing display corruption_ |
| ✅  | `8001-Add-APFS-driver` | `(+26938/-0)[34A]` | b9b88d83db0081ddf4f099baa69ace2dd28e5be3 `unicode.c`, `inode.c`, `extents.c`, `super.c`, `node.c`, `apfs_raw.h`, `dir.c`, `spaceman.c`, `apfs.h`, `btree.c`, `transaction.c`, `xattr.c`, `lzfse_decode_base.c`, `snapshot.c`, `lzfse_fse.h`, _and 19 more_ | `github-actions[bot]` _Add APFS driver_ |
| ✅  | `8002-Necessary-modifications-to-build-APFS-with-the-kerne` | `(+17/-20)[3M, 1A]` | d8c2b042ff6717d896210ca514ba75d8fb1c971c `Makefile`, `Kconfig` | `Aditya Garg` _Necessary modifications to build APFS with the kernel_ |


