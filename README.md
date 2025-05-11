#### kernel patching: 5 total patches; 5 applied; 1 with problems; 1 needs_rebase

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
|  🤖  ✅  | `[kernel-drivers/]` `sha1_636f0bbe70ae40dee416a2474498543e946b2503_rk35xx_vendor_b2283e49_3bddffba-01ba4719` | `(+0/-0)[]` | 69e4b9cf6b90d82bccde2d92aa00d27ff0b7389e `?` | `Armbian Autopatcher` _[AUTOGEN] /armbian/cache/patch/kernel-drivers/sha1_636f0bbe70ae40dee416a2474498543e946b2503_rk35xx_vendor_b2283e49_3bddffba-01ba4719_ |
| ✅  | `001-hid-sony` | `(+52/-20)[1M]` | 42bdbdbe0baef6036e6ebd44a9d9884753fabc98 `hid-sony.c` | `monkaBlyat` _[ARCHEOLOGY] vendor kernel patch for ds4 controllers_ |
| ✅   🫠`[user]`  | `1666-shutup-rockchip_canfd_get_berr_counter-RX_ERR_CNT-0x00000000-TX_ERR_CNT-0x00000000` | `(+3/-3)[1M]` | d619b368cc9404642411ae60abb278f787a7b98b `rockchip_canfd.c` | `Ricardo Pardini` _shutup rockchip_canfd_get_berr_counter RX_ERR_CNT=0x00000000 TX_ERR_CNT=0x00000000_ |
| ✅   🫠`[user]`  | `mekotronics-rk3588-fixes-for-SD-card-slow-but-works` | `(+0/-1)[1M]` | 1faa563fb1e6a18ba364daf23993c3f92d9401c6 `rk3588-blueberry-edge-v12.dtsi` | `Ricardo Pardini` _arm64: dts: mekotronics rk3588: fixes for SD card, slow but works_ |
| ⚠️`[needs_rebase]`   🫠`[user]`  | `r8169_mac_from_rk_vendor_storage` | `(+59/-0)[1M]` | f05e6143ea184d03542748d868f6da2d9b3013ce `r8169_main.c` | `zhangping` _initial rtl8152B two mac from emmc in rtl drivers by vendor storage driver_ |


