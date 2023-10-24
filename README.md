#### kernel patching: 24 total patches; 24 applied; 0 with problems

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
| ✅  | `0001-drm-msm-dpu1-improve-support-for-active-CTLs` | `(+17/-0)[2M]` | 21a0c2b95ccc0dcc8d2cefca2a237aae5a24948b `dpu_hw_ctl.c`, `dpu_hw_ctl.h` | `Dmitry Baryshkov` _drm/msm/dpu1: improve support for active CTLs_ |
| ✅  | `0002-drm-msm-dpu1-use-one-active-CTL-if-it-is-available` | `(+20/-6)[6M]` | 8954ce12327b45fb49354ecd3299d4055ca5940e `dpu_rm.c`, `dpu_encoder.c`, `dpu_5_0_sm8150.h`, `dpu_6_0_sm8250.h`, `dpu_hw_catalog.h`, `dpu_rm.h` | `Dmitry Baryshkov` _drm/msm/dpu1: use one active CTL if it is available_ |
| ✅  | `0003-drm-msm-dpu1-dpu_encoder_phys_-proper-suppor-for-act` | `(+6/-1)[2M]` | d20f7cea6f340b1a1c83778952c1474406ca8bb6 `dpu_encoder_phys_vid.c`, `dpu_encoder_phys_cmd.c` | `Dmitry Baryshkov` _drm/msm/dpu1: dpu_encoder_phys_*: proper suppor for active CTLs_ |
| ✅  | `0004-dt-bindings-mfd-qcom-qca639x-add-binding-for-QCA639x` | `(+84/-0)[1A]` | 77ec522499dad55c642b32a370efbb25d671c6de `qcom,qca639x.yaml` | `Dmitry Baryshkov` _dt-bindings: mfd: qcom,qca639x: add binding for QCA639x defvice_ |
| ✅  | `0005-mfd-qca639x-add-support-for-QCA639x-powerup-sequence` | `(+175/-0)[2M, 1A]` | b32aa09d6c54a4b487150d5c3eaaeeeef20d6691 `qcom-qca639x.c`, `Kconfig`, `Makefile` | `Dmitry Baryshkov` _mfd: qca639x: add support for QCA639x powerup sequence_ |
| ✅  | `0006-mfd-qcom-qca639x-switch-to-platform-config-data` | `(+46/-28)[1M]` | bf40a5e7d8ad34eb49c342ad5774d5b3a2df92e0 `qcom-qca639x.c` | `Dmitry Baryshkov` _mfd: qcom-qca639x: switch to platform config data_ |
| ✅  | `0007-mfd-qcom-qca639x-change-qca639x-to-use-gpios-rather-` | `(+19/-14)[1M]` | b7ef6f07671e8e90d799965b6095d70f35533045 `qcom-qca639x.c` | `Dmitry Baryshkov` _mfd: qcom-qca639x: change qca639x to use gpios rather than pinctrl_ |
| ✅  | `0008-Bluetooth-hci_qca-reopen-serial-port-after-toggling-` | `(+2/-0)[1M]` | 341e2de27a0c1d39ab736b8f341610b16d005ef9 `hci_qca.c` | `Dmitry Baryshkov` _Bluetooth: hci_qca: reopen serial port after toggling power_ |
| ✅  | `0009-drm-Add-drm-notifier-support` | `(+96/-1)[1M, 2A]` | c2b46170f74e8dab3159fe744d995f98a3a5c5ad `drm_notifier.c`, `drm_notifier.h`, `Makefile` | `Jianhua Lu` _drm: Add drm notifier support_ |
| ✅  | `0010-drm-dsi-emit-panel-turn-on-off-signal-to-touchscreen` | `(+9/-0)[1M]` | 386f55f9db32ed9487692d1f7672a72a7cc28075 `dsi_manager.c` | `Jianhua Lu` _drm: dsi: emit panel turn on/off signal to touchscreen_ |
| ✅  | `0011-Input-Add-nt36523-touchscreen-driver` | `(+3417/-0)[2M, 6A]` | 79c4d2773427afec3b7d44dd045926a946ddc4a0 `nt36xxx.c`, `nt36xxx_fw_update.c`, `nt36xxx_mem_map.h`, `nt36xxx.h`, `Kconfig`, `Makefile` | `Jianhua Lu` _Input: Add nt36523 touchscreen driver_ |
| ✅  | `0012-arm64-dts-qcom-sm8250-xiaomi-elish-enable-wifi-and-b` | `(+61/-0)[1M]` | 678883ab3b179508866b61086e4e264bc9a7ebec `sm8250-xiaomi-elish-common.dtsi` | `Jianhua Lu` _arm64: dts: qcom: sm8250-xiaomi-elish: enable wifi and bluetooth_ |
| ✅  | `0013-arm64-dts-qcom-sm8250-xiaomi-elish-enable-touchscree` | `(+42/-0)[3M]` | 27b2bb717f6d349c0f29864d8028e628992ca080 `sm8250-xiaomi-elish-common.dtsi`, `sm8250-xiaomi-elish-boe.dts`, `sm8250-xiaomi-elish-csot.dts` | `Jianhua Lu` _arm64: dts: qcom: sm8250-xiaomi-elish: enable touchscreen_ |
| ✅  | `0014-arm64-dts-qcom-sm8250-xiaomi-elish-Disable-slpi` | `(+1/-1)[1M]` | 00df7a2e215d414902e41144dd559992f9d3e53e `sm8250-xiaomi-elish-common.dtsi` | `Jianhua Lu` _arm64: dts: qcom: sm8250-xiaomi-elish: Disable slpi_ |
| ✅  | `0015-sound-soc-qcom-sm8250-Add-tdm-support` | `(+82/-0)[2M]` | 5c00cc139c075b22e76056d349b0e390b7939271 `sdw.c`, `sm8250.c` | `Jianhua Lu` _sound: soc: qcom: sm8250: Add tdm support_ |
| ✅  | `0016-arm64-dts-qcom-sm8250-xiaomi-elish-Add-sound-support` | `(+232/-0)[1M]` | 0c7d4a3c0fb43480f2d487d7f172be6e4a74d85f `sm8250-xiaomi-elish-common.dtsi` | `Jianhua Lu` _arm64: dts: qcom: sm8250-xiaomi-elish: Add sound support_ |
| ✅  | `0017-Asoc-wm_adsp-Add-prefix-support` | `(+14/-0)[1M]` | c8988e5cf476b52b76013dd9c63e76b700473e86 `wm_adsp.c` | `Jianhua Lu` _Asoc: wm_adsp: Add prefix support_ |
| ✅  | `0018-arm64-dts-qcom-sm8250-xiaomi-elish-Add-xiaomi-keyboa` | `(+56/-0)[1M]` | 913d625e32747c7f86125a5d3ed0788b784a3f4d `sm8250-xiaomi-elish-common.dtsi` | `Xin Xu` _arm64: dts: qcom: sm8250-xiaomi-elish: Add xiaomi-keyboard support_ |
| ✅  | `0019-drm-panel-nt36523-Fix-for-kernel-6.5` | `(+1/-0)[1M]` | 09305dfa8859ac4f71aa775b6c3c4ec4ae5e7202 `panel-novatek-nt36523.c` | `amazingfate` _drm/panel: nt36523: Fix for kernel 6.5_ |
| ✅  | `0020-drivers-input-misc-add-xiaomi-keyboard-vendor-driver` | `(+664/-0)[2M, 4A]` | a7fbe5781c8d0009239e514ae9e165a5c7c6f636 `xiaomi_keyboard.c`, `xiaomi_keyboard.h`, `Kconfig`, `Makefile` | `amazingfate` _drivers/input/misc: add xiaomi keyboard vendor driver_ |
| ✅  | `0021-arm64-dts-qcom-sm8250-xiaomi-elish-use-vendor-keyboa` | `(+31/-27)[1M]` | 36162f67c2617b2f3735beaac50694e5cfd2e6eb `sm8250-xiaomi-elish-common.dtsi` | `amazingfate` _arm64: dts: qcom: sm8250-xiaomi-elish: use vendor keyboard driver_ |
| ✅  | `0022-drivers-spmi-spmi-pmic-arb.c-remove-warnings` | `(+0/-1)[1M]` | 1f57987b28caf592c9b592d66c2a55ef0dbe4156 `spmi-pmic-arb.c` | `amazingfate` _drivers/spmi/spmi-pmic-arb.c: remove warnings_ |
| ✅  | `0023-tty-serial-qcom-geni-fix-zero-dma-rx-len-in` | `(+1/-1)[1M]` | 1a0cc50b73626ee7c7108868960d6b334930d7d6 `qcom_geni_serial.c` | `amazingfate` _tty: serial: qcom-geni: fix zero dma-rx-len-in_ |
| ✅  | `0024-Asoc-wm_adsp-Use-xiaomi-elish-firmware-name` | `(+1/-1)[1M]` | 6786135723b1bc5d9c9a1f484a0f11c3c0121f9f `wm_adsp.c` | `amazingfate` _Asoc: wm_adsp: Use xiaomi-elish firmware name_ |


