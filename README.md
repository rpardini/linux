#### kernel patching: 5 total patches; 5 applied; 2 with problems; 2 needs_rebase

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
|  🤖  ✅  | `[kernel-drivers/]` `sha1_d4576c5670090297b903771726a526f81fdd8c7c_arm64_current_558bb165_64e831fc-01ba4719` | `(+0/-0)[]` | 1c3920757eebab1f6448b5bf9773ce577aea30cd `?` | `Armbian Autopatcher` _[AUTOGEN] /armbian/cache/patch/kernel-drivers/sha1_d4576c5670090297b903771726a526f81fdd8c7c_arm64_current_558bb165_64e831fc-01ba4719_ |
| ✅  | `0010-arm64-swiotlb-Reduce-the-default-size-if-no-ZONE_DMA-bouncing-needed` | `(+10/-1)[1M]` | 1e849cd9b21e7d095533e65402414244889462e9 `init.c` | `Catalin Marinas` _arm64: swiotlb: Reduce the default size if no ZONE_DMA bouncing needed_ |
| ✅  | `board-hikey960-usb` | `(+33/-2)[1M]` | 119a9d9c28823d8e49f88cd39b3da0e05e265aec `hi3660-hikey960.dts` | `Kevin Schmidt` _[ARCHEOLOGY] Add board: HiKey960_ |
| ⚠️`[needs_rebase]`  | `driver-phytium-stmmac-acpi` | `(+531/-1)[7M, 1A]` | 710864817b7105aeeb3857258f3aa8124acc48cb `stmmac_platform.c`, `dwmac-phytium.c`, `at803x.c`, `dwmac-generic.c`, `Kconfig`, `stmmac_platform.h`, `Makefile`, `stmmac_main.c` | `Ricardo Pardini` _Phytium onboard ethernet drivers for 6.x_ |
| ⚠️`[needs_rebase]`  | `fix-stmmac-acpi-glue-for-Feiteng-on-6.6.y` | `(+8/-6)[2M]` | 7e4481ef8c092df205173cd07d67479b1974cce3 `dwmac-phytium.c`, `stmmac_platform.c` | `Ricardo Pardini` _fix stmmac acpi glue for Feiteng on 6.6.y_ |


