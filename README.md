#### kernel patching: 39 total patches; 39 applied; 0 with problems

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
|  🤖  ✅  | `[kernel-drivers/]` `sha1_458fbaaefba2fc5450c325a6834453dc4f4e52ae_x86_edge_7115a52c_ceaab8e6-01ba4719` | `(+0/-0)[]` | 3f86d24b357e89fb99bbad6dac4671acec218911 `?` | `Armbian Autopatcher` _[AUTOGEN] /armbian/cache/patch/kernel-drivers/sha1_458fbaaefba2fc5450c325a6834453dc4f4e52ae_x86_edge_7115a52c_ceaab8e6-01ba4719_ |
| ✅  | `1001-Add-t2bce-driver-stack` | `(+8228/-0)[30A]` | ddd554b6bb09e5cd48547fff014ad2d3a7951e42 `vhci.c`, `transfer.c`, `audio.c`, `t2bce_main.c`, `pcm.c`, `transport.c`, `protocol.c`, `queue.c`, `protocol_bce.c`, `mailbox.c`, `command.h`, `t2bce_dma_queue.h`, `audio.h`, `protocol.h`, `transfer.h`, _and 10 more_ | `github-actions[bot]` _Add t2bce driver stack_ |
| ✅  | `1002-Integrate-t2bce-driver-stack` | `(+3/-0)[2M]` | bd72da00c9712f99a7c835888ecf74504e13b5f2 `Kconfig`, `Makefile` | `github-actions[bot]` _Integrate t2bce driver stack_ |
| ✅  | `2008-i915-4-lane-quirk-for-mbp15-1` | `(+19/-0)[3M]` | 4fbfac60d409abf3d89f5be228b6792010b2e1d5 `intel_quirks.c`, `intel_ddi.c`, `intel_quirks.h` | `Orlando Chamberlain` _i915: 4 lane quirk for mbp15,1_ |
| ✅  | `2009-apple-gmux-allow-switching-to-igpu-at-probe` | `(+23/-6)[4M]` | 0ee68c88a23d9466110275e2123992601ae47e23 `apple-gmux.c`, `vga_switcheroo.c`, `amdgpu_drv.c`, `vgaarb.c` | `Orlando Chamberlain` _apple-gmux: allow switching to igpu at probe_ |
| ✅  | `3001-applesmc-convert-static-structures-to-drvdata` | `(+319/-221)[1M]` | fdefe1c1f1231813304cab582ca535d8206333f1 `applesmc.c` | `Paul Pawlowski` _applesmc: convert static structures to drvdata_ |
| ✅  | `3002-applesmc-make-io-port-base-addr-dynamic` | `(+49/-42)[1M]` | ad029af911124247961eb77cbe6fb96c34787fe2 `applesmc.c` | `Paul Pawlowski` _applesmc: make io port base addr dynamic_ |
| ✅  | `3003-applesmc-switch-to-acpi_device-from-platform` | `(+84/-40)[1M]` | d17be2f5631acafaed459e3857148d007464c82a `applesmc.c` | `Paul Pawlowski` _applesmc: switch to acpi_device (from platform)_ |
| ✅  | `3004-applesmc-key-interface-wrappers` | `(+79/-40)[1M]` | 8fa94e83f9a7c5d4657665486dba618869e27242 `applesmc.c` | `Paul Pawlowski` _applesmc: key interface wrappers_ |
| ✅  | `3005-applesmc-basic-mmio-interface-implementation` | `(+231/-6)[1M]` | 1077d42e79d4169c41fa4ad27102bf92312a61da `applesmc.c` | `Aun-Ali Zaidi` _applesmc: basic mmio interface implementation_ |
| ✅  | `3006-applesmc-fan-support-on-T2-Macs` | `(+102/-17)[1M]` | afc095bae84288c1ee6b7b7b1f7bfd5e3b6c3363 `applesmc.c` | `Paul Pawlowski` _applesmc: fan support on T2 Macs_ |
| ✅  | `3007-applesmc-Add-iMacPro-to-applesmc_whitelist` | `(+4/-0)[1M]` | 569d7b8b1486a3429e0b61bf21c69042c6dcb7fd `applesmc.c` | `Orlando Chamberlain` _applesmc: Add iMacPro to applesmc_whitelist_ |
| ✅  | `3008-applesmc-make-applesmc_remove-void` | `(+2/-2)[1M]` | d41f5be7173b5848179a5e746a43e1c2b6a41bf7 `applesmc.c` | `Orlando Chamberlain` _applesmc: make applesmc_remove void_ |
| ✅  | `3009-applesmc-battery-charge-limiter` | `(+41/-1)[1M]` | 96d90ae33d1ffeb101e893cde557cde83745ecf8 `applesmc.c` | `Orlando Chamberlain` _applesmc: battery charge limiter_ |
| ✅  | `4001-asahi-trackpad` | `(+13/-1)[3M]` | c8de698c2ff20b52ff0e364583c74a6d8a1a3909 `hid.h`, `hid-ids.h`, `hid-core.c` | `Janne Grunau` _HID: add device IDs for Apple SPI HID devices_ |
| ✅  | `4001-asahi-trackpad` | `(+5/-0)[1M]` | c4a122729e5ee749a14423d704a63ba4ee36a0cf `hid-ids.h` | `Hector Martin` _HID: add HOST vendor/device IDs for Apple MTP devices_ |
| ✅  | `4001-asahi-trackpad` | `(+3/-0)[1M]` | 27d628c96f35aaebb7f2a93d9a148a28d39f3ddb `hid-core.c` | `Hector Martin` _HID: core: Handle HOST bus type when announcing devices_ |
| ✅  | `4001-asahi-trackpad` | `(+4/-1)[1M]` | 6dc420e282eaf3c9a3c040b7b5b3f2ca50862d74 `hid-core.c` | `Hector Martin` _HID: Bump maximum report size to 16384_ |
| ✅  | `4001-asahi-trackpad` | `(+16/-0)[2M]` | af57f58160b4f86ce9de5698fc1610fc976bfcee `hid-apple.c`, `Kconfig` | `Janne Grunau` _HID: apple: Bind Apple silicon SPI devices_ |
| ✅  | `4001-asahi-trackpad` | `(+5/-2)[1M]` | be6830de88db8ad11bf82dee52b488e2a4ad0071 `hid-apple.c` | `Hector Martin` _HID: apple: Bind to HOST devices for MTP_ |
| ✅  | `4001-asahi-trackpad` | `(+5/-3)[1M]` | 7debe02badcd41f3440b76d05e8d56cfdfb5d3d3 `hid-magicmouse.c` | `Janne Grunau` _HID: magicmouse: use a define of the max number of touch contacts_ |
| ✅  | `4001-asahi-trackpad` | `(+5/-5)[1M]` | 56e3eee56152fabfffa16e0cb0c494b13447eb80 `hid-magicmouse.c` | `Janne Grunau` _HID: magicmouse: use struct input_mt_pos for X/Y_ |
| ✅  | `4001-asahi-trackpad` | `(+31/-1)[1M]` | 223d8e216dd05bd643288badfa025a01adbd696e `hid-magicmouse.c` | `Janne Grunau` _HID: magicmouse: use ops function pointers for input functionality_ |
| ✅  | `4001-asahi-trackpad` | `(+266/-4)[2M]` | a635d21b8b08a92b548a42015c7f850732a5e312 `hid-magicmouse.c`, `Kconfig` | `Janne Grunau` _HID: magicmouse: add support for Macbook trackpads_ |
| ✅  | `4001-asahi-trackpad` | `(+47/-16)[1M]` | 4ffd2588498c74dca9dd8c8baf948c5dfa7708df `hid-magicmouse.c` | `Hector Martin` _HID: magicmouse: Add MTP multi-touch device support_ |
| ✅  | `4001-asahi-trackpad` | `(+87/-21)[1M]` | bfc2bd7d2071a0dd92a3957f9f50dcab12339558 `hid-magicmouse.c` | `Hector Martin` _HID: magicmouse: Handle touch controller resets on SPI devices_ |
| ✅  | `4001-asahi-trackpad` | `(+80/-24)[1M]` | 7015ce70acabf334a15a8d21863c4ae61a24c52f `hid-magicmouse.c` | `Hector Martin` _HID: magicmouse: Query device dimensions via HID report_ |
| ✅  | `4001-asahi-trackpad` | `(+1422/-0)[2M, 5A]` | cb06c98761ac83b152328509813a2078e1b530e4 `spi-hid-apple-core.c`, `spi-hid-apple-of.c`, `spi-hid-apple.h`, `Kconfig`, `Makefile` | `Janne Grunau` _WIP: HID: transport: spi: add Apple SPI transport_ |
| ✅  | `4001-asahi-trackpad` | `(+445/-0)[2M, 2A]` | fd337a4ba19dba6fa702854ca9f9e58a4a10b736 `dockchannel.c`, `dockchannel.h`, `Kconfig`, `Makefile` | `Hector Martin` _soc: apple: Add DockChannel driver_ |
| ✅  | `4001-asahi-trackpad` | `(+1239/-0)[2M, 3A]` | d8b099f825a6a9eac67f4e92969bb2cb1c068c02 `dockchannel-hid.c`, `Kconfig`, `Makefile` | `Hector Martin` _HID: Add Apple DockChannel HID transport driver_ |
| ✅  | `4001-asahi-trackpad` | `(+168/-0)[2M, 1A]` | 87d3c4480c11a79a30d84f61fab958c8a1c6915f `rtkit-helper.c`, `Kconfig`, `Makefile` | `Hector Martin` _soc: apple: Add RTKit helper driver_ |
| ✅  | `4003-HID-apple-ignore-the-trackpad-on-T2-Macs` | `(+17/-10)[1M]` | 1fc8801c10e7bd9dc2ae092aeb3e8d52e254f810 `hid-apple.c` | `Aditya Garg` _HID: apple: ignore the trackpad on T2 Macs_ |
| ✅  | `4004-HID-magicmouse-Add-support-for-trackpads-found-on-T2` | `(+275/-21)[1M]` | 29fbdc9c1b253e5e27dae7fd3484a6276e27b501 `hid-magicmouse.c` | `Aditya Garg` _HID: magicmouse: Add support for trackpads found on T2 Macs_ |
| ✅  | `4005-HID-magicmouse-fix-regression-breaking-support-for-M` | `(+6/-9)[1M]` | 40bb4897fc976795923e6d4d4cf2b20139b4bd58 `hid-magicmouse.c` | `Aditya Garg` _HID: magicmouse: fix regression breaking support for Magic Trackpad 1_ |
| ✅  | `5001-HID-appletb-kbd-add-option-to-switch-default-layer-o` | `(+53/-7)[1M]` | 5c2338e2c98945835cde7b3322f633c0d30d8fbc `hid-appletb-kbd.c` | `Aditya Garg` _HID: appletb-kbd: add option to switch default layer on double pressing fn key_ |
| ✅  | `6001-drm-amd-pm-Fix-boot-problems-in-5300` | `(+16/-0)[1M]` | b8d1137b42164975854597c578f6a152da9f2b11 `smu_v11_0.c` | `Atharva Tiwari` _drm/amd/pm: Fix boot problems in 5300_ |
| ✅  | `7001-drm-i915-fbdev-Discard-BIOS-framebuffers-exceeding-h` | `(+3/-3)[1M]` | 7c9e605e3da40956713ae42a70abd98d704a9c4a `intel_fbdev.c` | `Ashish Arora` _Re: [PATCH] drm/i915: Discard large BIOS framebuffers causing display corruption._ |
| ✅  | `7002-drm-amdgpu-reset-VI-ASIC-on-MacBookPro15-1` | `(+20/-0)[1M]` | 233ec78c52de1e5205e23c2f047a6a1379fadda8 `vi.c` | `Andre Eikmeyer` _drm/amdgpu: reset VI ASIC on MacBookPro15,1_ |
| ✅  | `9001-ACPI-x86-Apple-T2-systems-need-early-CPU-offlining` | `(+131/-0)[1M]` | 7900f1dd2059713a1bc29f3c113e1faba8a3c0db `apple.c` | `Andre Eikmeyer` _ACPI: x86: Apple T2 systems need early CPU offlining_ |


