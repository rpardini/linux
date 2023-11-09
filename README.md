#### kernel patching: 132 total patches; 132 applied; 0 with problems

| Status | Patch  | Diffstat Summary | Files patched | Author / Subject |
| :---:    | :---   | :---   | :---   | :---  |
|  🤖  ✅  | `[kernel-drivers/]` `sha1_46df6964c1a9eb72027710f626cb1c6bfb5d58c9_media_edge_6f348e648f569189-01ba4719` | `(+0/-0)[]` | 3cc763b084f4207f1f1850e55415d2c1d3d59974 `?` | `Armbian Autopatcher` _[AUTOGEN] /armbian/cache/patch/kernel-drivers/sha1_46df6964c1a9eb72027710f626cb1c6bfb5d58c9_media_edge_6f348e648f569189-01ba4719_ |
| ✅  | `00100-v91-i2s-mclk` | `(+34/-7)[2M]` | c2282bf3b4f3192aae1a596fdf16851b86af2090 `clk-rk3568.c`, `rk3568-cru.h` | `Jianfeng Liu` _[ARCHEOLOGY] add rk809 codec sound support to radxa rock3a (#3621)_ |
| ✅  | `00110-v91-irq-gic-v3-its` | `(+65/-5)[1M]` | d99b5be267738e9bd10b0880513ae52ab8ab8122 `irq-gic-v3-its.c` | `Oleg` _[ARCHEOLOGY] Adding Pine64 Quartz64a as WIP target (#3539)_ |
| ✅  | `00120-rk356x-dtsi` | `(+1/-1)[1M]` | 815f0ed5208a133eb473f86381d5251b49a49b75 `rk356x.dtsi` | `Oleg` _[ARCHEOLOGY] move media current 5.19 and edge 6.0 (#4262)_ |
| ✅  | `00130-board-firefly-rk3399-dts` | `(+60/-731)[1M]` | 266478a90c46fb00d0bd2384e6fd3769a05bed9e `rk3399-firefly.dts` | `Oleg` _[ARCHEOLOGY] fix firefly-rk3399 (#2758)_ |
| ✅  | `00140-v95-make` | `(+2/-0)[1M]` | 82ea6ab9a51a5c218a8a62a71d5859c380a8f5b8 `Makefile` | `Oleg` _[ARCHEOLOGY] Adding Pine64 Quartz64a as WIP target (#3539)_ |
| ✅  | `00150-v95-rk3566-firefly-roc-pc` | `(+773/-0)[1A]` | e8639b5bfad0c1e093b646710f72ef6477dc2854 `rk3566-firefly-roc-pc.dts` | `Oleg` _[ARCHEOLOGY] move kernel edge to 5.16 (#3387)_ |
| ✅  | `00160-v95-rk3568-bpi-r2pro` | `(+122/-2)[1M]` | adc10e5984238673f9f17fe343bbc976cccb3491 `rk3568-bpi-r2-pro.dts` | `Oleg` _[ARCHEOLOGY] move 5.18-rc5 support jetson-nano (#3754)_ |
| ✅  | `00170-v95-rk3568-firefly-roc-pc` | `(+1044/-0)[1A]` | 078bcd813a01338c957c70cb014aaff56af82aa2 `rk3568-firefly-roc-pc.dts` | `Oleg` _[ARCHEOLOGY] move kernel edge to 5.16 (#3387)_ |
| ✅  | `00180-linux-0002-rockchip-from-list` | `(+2/-2)[1M]` | ff0453731dbf63dd68d8e12a063f22b0a3c1ab19 `phy-rockchip-inno-hdmi.c` | `Jonas Karlman` _phy/rockchip: inno-hdmi: use correct vco_div_5 macro on rk3328_ |
| ✅  | `00180-linux-0002-rockchip-from-list` | `(+5/-3)[1M]` | 23bc1dfd811fdda4f9d37cd760fe119c545a0a70 `phy-rockchip-inno-hdmi.c` | `Zheng Yang` _phy/rockchip: inno-hdmi: round fractal pixclock in rk3328 recalc_rate_ |
| ✅  | `00180-linux-0002-rockchip-from-list` | `(+1/-4)[1M]` | 58e9071b7401d726de5909c15514c6c5df763498 `phy-rockchip-inno-hdmi.c` | `Jonas Karlman` _phy/rockchip: inno-hdmi: remove unused no_c from rk3328 recalc_rate_ |
| ✅  | `00180-linux-0002-rockchip-from-list` | `(+4/-2)[1M]` | 99a1df64bd491cafe3d37cc5654d746497e2875d `phy-rockchip-inno-hdmi.c` | `Jonas Karlman` _phy/rockchip: inno-hdmi: do not power on rk3328 post pll on reg write_ |
| ✅  | `00180-linux-0002-rockchip-from-list` | `(+13/-0)[1M]` | d8c5c577d02861d982b7565d8ed833c1d87118c3 `phy-rockchip-inno-hdmi.c` | `Huicong Xu` _phy/rockchip: inno-hdmi: force set_rate on power_on_ |
| ✅  | `00180-linux-0002-rockchip-from-list` | `(+8/-0)[1M]` | 980653569412ee4a8961d31bdbff8d58fe5758fb `core.c` | `Jonas Karlman` _mmc: core: set initial signal voltage on power off_ |
| ✅  | `00180-linux-0002-rockchip-from-list` | `(+14/-0)[1M]` | 2bf2ba5c396bb4974caee1a217cceb9ba80e3eb8 `rk3328.dtsi` | `Alex Bee` _arm64: dts: rockchip: Add sdmmc_ext for RK3328_ |
| ✅  | `00180-linux-0002-rockchip-from-list` | `(+6/-0)[1M]` | a4969d7c37f06dbde94b544c09dd5cc57fa4425f `rk3328.dtsi` | `Alex Bee` _arm64: dts: rockchip: Add sdmmc/sdio/emmc reset controls for RK3328_ |
| ✅  | `00181-linux-0011-v4l2-from-list` | `(+38/-39)[1M]` | e0374f5002a189284ab3c1720b4ac9b8c11c934a `v4l2-common.c` | `Jonas Karlman` _media: v4l2-common: Add helpers to calculate bytesperline and sizeimage_ |
| ✅  | `00181-linux-0011-v4l2-from-list` | `(+8/-0)[3M]` | 0bb3ece43e5f8cae03a14850e56e062578320d87 `v4l2-common.c`, `videodev2.h`, `v4l2-ioctl.c` | `Jonas Karlman` _media: v4l2: Add NV15 and NV20 pixel formats_ |
| ✅  | `00181-linux-0011-v4l2-from-list` | `(+5/-5)[1M]` | 45968cec8af7f885a3a77b4899b26eb1b8cd303e `rkvdec-h264.c` | `Jonas Karlman` _media: rkvdec: h264: Use bytesperline and buffer height to calculate stride_ |
| ✅  | `00181-linux-0011-v4l2-from-list` | `(+15/-14)[1M]` | ce05030c3e2e4c604fdf4151d34703b50f878cdb `rkvdec.c` | `Jonas Karlman` _media: rkvdec: Extract rkvdec_fill_decoded_pixfmt helper method_ |
| ✅  | `00181-linux-0011-v4l2-from-list` | `(+61/-8)[2M]` | e2c7cb1e844bf492b953bad12995b5bf4293876c `rkvdec.c`, `rkvdec.h` | `Jonas Karlman` _media: rkvdec: Lock capture pixel format in s_ctrl and s_fmt_ |
| ✅  | `00181-linux-0011-v4l2-from-list` | `(+37/-15)[2M]` | 8e212413c4bb464afea14fd1388c7d5707763ce5 `rkvdec-h264.c`, `rkvdec.c` | `Jonas Karlman` _media: rkvdec: h264: Support High 10 and 4:2:2 profiles_ |
| ✅  | `00181-linux-0011-v4l2-from-list` | `(+7/-6)[1M]` | 39c57964a33e43afb24197d57084fb34543e94ab `rkvdec-h264.c` | `Alex Bee` _media: rkvdec-h264: Don't hardcode SPS/PPS parameters_ |
| ✅  | `00182-linux-0020-drm-from-list` | `(+10/-0)[2M]` | 0cfefbf7c39cdc112e91e631bc595ad26f564c99 `drm_fourcc.c`, `drm_fourcc.h` | `Jonas Karlman` _drm: drm_fourcc: add NV20 and NV30 YUV formats_ |
| ✅  | `00182-linux-0020-drm-from-list` | `(+54/-8)[3M]` | ee93bb8314c4946c854a5b47c0f17ee7f2086506 `rockchip_vop_reg.c`, `rockchip_drm_vop.c`, `rockchip_drm_vop.h` | `Jonas Karlman` _drm: rockchip: add NV15, NV20 and NV30 support_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+5/-1)[1M]` | 2dc03dd0fc3cee16fe79699816a69543fa5a436a `rockchip_drm_vop.c` | `Jonas Karlman` _drm/rockchip: vop: fix crtc duplicate state_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+54/-0)[1M]` | e398394d13cc835711b6b81af6b8f5274004d85e `rockchip_drm_vop.c` | `Jonas Karlman` _drm/rockchip: vop: filter modes outside 0.5% pixel clock tolerance_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+3/-0)[1M]` | 11348f31075b022e7aaf96c774206fe35f7b1262 `rockchip_drm_vop.c` | `Jonas Karlman` _drm/rockchip: vop: filter interlaced modes_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+13/-5)[3M]` | 8331862403c14f3f0ae95b3cfae3cd5f3f5294f0 `rockchip_vop_reg.c`, `rockchip_drm_vop.h`, `rockchip_drm_vop2.h` | `Jonas Karlman` _drm/rockchip: vop: define max output resolution supported_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+34/-14)[1M]` | a5d042b5d9eedad12704cefa1080a15d94364e6d `rockchip_drm_vop.c` | `Jonas Karlman` _drm/rockchip: vop: filter modes above max output supported_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+1/-1)[1M]` | 515064c703289ff166065db551f5002c1f422c25 `dw_hdmi-rockchip.c` | `Yakir Yang` _drm/rockchip: dw_hdmi: adjust cklvl & txlvl for RF/EMI_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+1/-0)[1M]` | 05d3268235034ff1921cb1d3d1adcaefa2c655aa `dw_hdmi-rockchip.c` | `Nickey Yang` _drm/rockchip: dw_hdmi: add phy_config for 594Mhz pixel clock_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+2/-14)[1M]` | c0b1657ce875d301b6e69a5425ef2d08e8c5364e `dw_hdmi-rockchip.c` | `Douglas Anderson` _drm/rockchip: dw_hdmi: Set cur_ctr to 0 always_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+69/-61)[1M]` | 7c3301250853abb02a38a7c0bb1fbde734eacee7 `dw_hdmi-rockchip.c` | `Douglas Anderson` _drm/rockchip: dw_hdmi: Use auto-generated tables_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+4/-12)[1M]` | 830e39408152037048d2c58833680a88c9df1470 `dw_hdmi-rockchip.c` | `Jonas Karlman` _drm/rockchip: dw-hdmi: limit tmds to 340mhz_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+2/-0)[1M]` | 17dc74db7691a3af860519e8b1dabfb1aa9bf4ae `dw_hdmi-rockchip.c` | `Jonas Karlman` _drm/rockchip: dw-hdmi: allow high tmds bit rates_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+0/-6)[1M]` | 08591702ef58c97862753309a7944da5089fb322 `dw_hdmi-rockchip.c` | `Jonas Karlman` _drm/rockchip: dw-hdmi: remove unused plat_data on rk3228/rk3328_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+8/-2)[1M]` | d402e49b5b843a9b7d1d686209bb93e1bf277b81 `dw_hdmi-rockchip.c` | `Jonas Karlman` _drm/rockchip: dw-hdmi: encoder error handling_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+1/-1)[1M]` | fdba369ca85a00e635def052316537bd6dac40c1 `clk-rk3228.c` | `Jonas Karlman` _clk: rockchip: set parent rate for DCLK_VOP clock on rk3228_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+18/-3)[1M]` | b48eed3268c215f3c7ffad2ec39e9b9705a00182 `rockchip_vop_reg.c` | `Jonas Karlman` _drm/rockchip: vop: split rk3288 vop_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+2/-2)[1M]` | 946ada0890eea231c54b6dde416ab58ea6fd6a19 `rk3288.dtsi` | `Jonas Karlman` _ARM: dts: rockchip: split rk3288 vop_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+10/-6)[3M]` | eaa343a877aab887c0d4e86e33836bebba0433d1 `dw-hdmi.c`, `rcar_dw_hdmi.c`, `dw_hdmi.h` | `Jonas Karlman` _drm/bridge: dw-hdmi: add mtmdsclock parameter to phy configure ops_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+12/-5)[1M]` | 258a29374f2b8b5c335fe201f3eaee3a5187c818 `dw-hdmi.c` | `Jonas Karlman` _drm/bridge: dw-hdmi: support configuring phy for deep color_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+4/-1)[2M]` | beba05f6870fad2e13b11d55d2c26a800de859c1 `dw-hdmi.c`, `dw_hdmi.h` | `Jonas Karlman` _drm/bridge: dw-hdmi: add mpll_cfg_420 for ycbcr420 mode_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+10/-2)[1M]` | 34b03c3282b39038a9994c2406f727408d86e84b `dw_hdmi-rockchip.c` | `Jonas Karlman` _drm/rockchip: dw-hdmi: mode_valid: allow 420 clock rate_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+41/-0)[1M]` | 62621a5e0d9c788cd9f08bc23da7dad854712000 `dw_hdmi-rockchip.c` | `Jonas Karlman` _drm/rockchip: dw-hdmi: add YCbCr420 mpll cfg for rk3399_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+41/-0)[1M]` | c0e692f9a7d7b196129c009444581e63d7aa53f1 `dw_hdmi-rockchip.c` | `Shunqing Chen` _drm/rockchip: dw-hdmi: add YCbCr420 mpll cfg for rk3288w_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+81/-37)[1M]` | e591ef01bfd3d14b3b874213e8b4f1e34f78602c `dw_hdmi-rockchip.c` | `Jonas Karlman` _drm/rockchip: dw-hdmi: add bridge and switch to drm_bridge_funcs_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+6/-2)[2M]` | 8e6633cd6c865a77c8c0c0c72ad2d4aaa9bba2ed `rockchip_drm_vop.c`, `rockchip_drm_fb.c` | `Jonas Karlman` _drm/rockchip: vop: add immutable zpos property_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+30/-2)[1M]` | d7d6d783d4a10dfb5654ac9062165d1a329ae14f `rockchip_drm_vop.c` | `Jonas Karlman` _drm/rockchip: vop: add plane color properties_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+7/-4)[2M]` | 7835a0ba87dae5f992c5450b5b74d16013d8c767 `clk-rk3288.c`, `rk3288.dtsi` | `Nickey Yang` _HACK: clk: rockchip: rk3288: dedicate npll for vopb and hdmi use_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+38/-1)[1M]` | 9a73600b3043c9d793563ef50cc2d14479ce12f7 `clk-rk3288.c` | `Jonas Karlman` _HACK: clk: rockchip: rk3288: use npll table to to improve HDMI compatibility_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+42/-7)[1M]` | 41e9f19f9eb911a8374d3268e546a2ddd5ba1e00 `clk-rk3399.c` | `Jonas Karlman` _HACK: clk: rockchip: rk3399: dedicate vpll for vopb and hdmi use_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+0/-18)[2M]` | 726f1eea6174ff63b7986350692fd884a21daa38 `rk3288.dtsi`, `rk3399.dtsi` | `Jonas Karlman` _HACK: dts: rockchip: do not use vopl for hdmi_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+76/-44)[1M]` | 7ff15dbdc5fb6055cfc591b974194be73c26d6f5 `dw-hdmi.c` | `Jonas Karlman` _WIP: drm/bridge: dw-hdmi: limit mode and bus format to max_tmds_clock_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+43/-0)[2M]` | 9cf5ecada884d6fab7a57cd271d38002f5f66a97 `dw_hdmi-rockchip.c`, `rockchip_drm_drv.h` | `Jonas Karlman` _WIP: drm/rockchip: dw_hdmi: add 10-bit rgb bus format_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+7/-1)[1M]` | f945d0f34bff82963b0c7ea3a076159a1ecb8cb2 `dw-hdmi.c` | `Jonas Karlman` _WIP: drm: dw-hdmi: add content type connector property_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+82/-1)[4M]` | 124747960c4b01afd8916a1dd64818644819ee2b `dw_hdmi-rockchip.c`, `rockchip_drm_vop.c`, `rockchip_vop_reg.c`, `rockchip_drm_vop.h` | `Jonas Karlman` _WIP: drm/rockchip: add yuv444 support_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+48/-5)[4M]` | 5fa48a1bfbd6f05511d4e9b70f648982115d6694 `dw_hdmi-rockchip.c`, `rockchip_drm_vop.c`, `rockchip_drm_vop.h`, `rockchip_vop_reg.c` | `Jonas Karlman` _WIP: drm/rockchip: add yuv420 support_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+2/-0)[1M]` | bd9f58a5d9396b09bc2dc57f5f435aef6d142a59 `dw_hdmi-rockchip.c` | `Alex Bee` _drm/rockchip: enable ycbcr_420_allowed and ycbcr_444_allowed for RK3228_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+15/-2)[1M]` | d8723f015dae6591d5e444d7abb30ae8062f6d09 `dw_hdmi-rockchip.c` | `Alex Bee` _drm/rockchip: seperate mode clock validation_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+10/-3)[1M]` | dd62e370afcd33b2079d4a1d8f378393e963b8d2 `rockchip_drm_vop.c` | `Jonas Karlman` _rockchip: vop: force skip lines if image too big_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+2/-2)[1M]` | a41ef66dbb1fb5a2d318cb7de50fceb1cdde610d `rk3328.dtsi` | `Jonas Karlman` _arm64: dts: rockchip: increase vop clock rate on rk3328_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+6/-6)[1M]` | 38ccc78f0aabcb35f0d77ecb776a20a6db7ebf9e `dw-hdmi.c` | `Alex Bee` _drm/bridge: dw-hdmi: fix RGB to YUV color space conversion_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+173/-25)[1M]` | df2b50667cf10c5940124b142d93dd2d9f168701 `phy-rockchip-inno-hdmi.c` | `Alex Bee` _phy/rockchip: inno-hdmi: add more supported pre-pll rates_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+2/-2)[1M]` | 60b83969f16c5d85af6f4cbc9b862b8031c84158 `rockchip_drm_vop.c` | `Alex Bee` _drm/rockchip: allow 4096px width modes_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+29/-1)[4M]` | 8efbe4fba2de5043a9be47176f2c38dd6403324c `cec-core.c`, `cec-adap.c`, `cec.h`, `cec-priv.h` | `Jonas Karlman` _media: cec-adap: add debounce support when setting an invalid phys addr_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+8/-6)[1M]` | 62ae108fdf3740aa498019cf5bca1c5a2383e219 `dw-hdmi.c` | `Alex Bee` _WIP: drm/bridge: synopsys: Fix CEC not working after power-cyclying_ |
| ✅  | `00183-linux-1000-drm-rockchip` | `(+4/-32)[1M]` | 44dc5fead01a65d6c9911c246e816fb83683de6b `rockchip_drm_vop.c` | `Jonas Karlman` _drm/rockchip: vop: create planes in window order_ |
| ✅  | `00184-linux-1001-v4l2-rockchip` | `(+2/-2)[1M]` | bcc4b75c2819fcf6fad90e089e55ffe971fe1643 `rkvdec.c` | `Jonas Karlman` _WIP: media: rkvdec: pm runtime dont use autosuspend before disable and cleanup_ |
| ✅  | `00184-linux-1001-v4l2-rockchip` | `(+44/-0)[2M, 1A]` | 52dd2c0a9c81e2f10499ddeb136601be551ce176 `pm_domains.c`, `rockchip_pmu.h`, `pm_domains.h` | `Randy Li` _soc: rockchip: power-domain: export idle request_ |
| ✅  | `00184-linux-1001-v4l2-rockchip` | `(+87/-1)[4M]` | 8a704b2acafd43e1273a101d0f089b3c7a0a6dfe `rkvdec.c`, `rockchip,vdec.yaml`, `rkvdec.h`, `rkvdec-regs.h` | `Alex Bee` _WIP: media: rkvdec: implement reset controls_ |
| ✅  | `00184-linux-1001-v4l2-rockchip` | `(+9/-1)[1M]` | 8ee5454736f07589e14c08ce2811f0bf982f5069 `rk3399.dtsi` | `Alex Bee` _WIP: arm64: dts: add resets to vdec for RK3399_ |
| ✅  | `00184-linux-1001-v4l2-rockchip` | `(+1/-1)[1M]` | 93e77f0a3c2b0a64abc5e5ec9720b8e18de12c45 `rk3399.dtsi` | `Alex Bee` _arm64: dts: rockchip: fix RK3399 vdec register witdh_ |
| ✅  | `00184-linux-1001-v4l2-rockchip` | `(+11/-3)[1M]` | fecee2e19d15003adfaf871278db4cac672e3326 `rockchip_vpu_hw.c` | `Alex Bee` _media: hantro: rockchip: Increase RK3288's max ACLK_ |
| ✅  | `00184-linux-1001-v4l2-rockchip` | `(+10/-0)[2M]` | 2f6cdaa6bdd9e48bd8d1db88034fd3ba2ddfaf0c `rkvdec-vp9.c`, `rkvdec-regs.h` | `Alex Bee` _media: rkvdec: disable QoS for VP9 (corruptions on RK3328 otherwise)_ |
| ✅  | `00184-linux-1001-v4l2-rockchip` | `(+5/-0)[1M]` | df0afddfb6ceecf2008587e8e0c6e85ec43dbb68 `rk3328.dtsi` | `Alex Bee` _WIP: arm64: dts: add resets to vdec for RK3328_ |
| ✅  | `00185-linux-1002-for-libreelec` | `(+43/-0)[3M]` | 415cea9bd7914b21cf33baf714d802fc36c0f38a `rk3328.dtsi`, `rk3328-roc-cc.dts`, `rk3328-rock64.dts` | `Alex Bee` _arm64: dts: rockchip: add gpu powerdomain, gpu opp-table and cooling cell for RK3328_ |
| ✅  | `00185-linux-1002-for-libreelec` | `(+20/-0)[1M]` | d9e7739ba4d54774217a15547973ff98f3b2d482 `rk3288-miqi.dts` | `Alex Bee` _ARM: dts: RK3288 miqi add hdmi sound nodes_ |
| ✅  | `00185-linux-1002-for-libreelec` | `(+2/-2)[2M]` | 4d33ca30fb08a2862559188f5e7432bda5aa9efd `rk3288-tinker.dtsi`, `rk3399.dtsi` | `Alex Bee` _ARM/arm64: dts: rockchip: align sound card names_ |
| ✅  | `00185-linux-1002-for-libreelec` | `(+1/-1)[1M]` | 1a77cc3cbea3e795fc5e1ecf3a8e37145bdfcf36 `drm_gem.c` | `Alex Bee` _HACK: drm/gem: suppress warning about missing vm_flags_ |
| ✅  | `00185-linux-1002-for-libreelec` | `(+52/-61)[1M]` | 6ea0833601aa5379afd0241ae3b31211cf7d8172 `hdmi-codec.c` | `Jonas Karlman` _ASoC: hdmi-codec: fix channel allocation_ |
| ✅  | `00185-linux-1002-for-libreelec` | `(+23/-0)[1M]` | 454711173a3570653428024e83d48be4e9235ff7 `rk3328-a1.dts` | `Alex Bee` _arm64: dts: rockchip: add SPDIF nodes for RK3328 A1 board_ |
| ✅  | `00185-linux-1002-for-libreelec` | `(+14/-0)[1M]` | 4ce64243462040f804a211882117681d1defe854 `rk3328-roc-cc.dts` | `Alex Bee` _arm64: dts: rockchip: Add ir-receiver node for RK3328 ROC CC_ |
| ✅  | `00185-linux-1002-for-libreelec` | `(+2/-0)[1M]` | 9a8f4e02ff0907e9a91c40ab6c97a7d526cb80ce `rk3288-miqi.dts` | `Alex Bee` _ARM: dts: add cec pinctrl for RK3288 miqi board_ |
| ✅  | `00185-linux-1002-for-libreelec` | `(+8/-0)[1M]` | f0ae8f8d0db99b78501123feeb04e098520b68f1 `rk3328-a1.dts` | `Alex Bee` _HACK: arm64: dts: enable FE phy for Beelink A1 also_ |
| ✅  | `00185-linux-1002-for-libreelec` | `(+16/-2)[1M]` | 59f596e97bcce79d1c698f7e373869b33901cd8c `dw-hdmi-cec.c` | `Jonas Karlman` _WIP: dw-hdmi-cec: sleep 100ms on error_ |
| ✅  | `00185-linux-1002-for-libreelec` | `(+1/-1)[1M]` | a6581da3f1b4b7162c8f427506739e0809257b15 `rk3399.dtsi` | `Alex Bee` _arm64: boot: dts: Increase ACLK_PERILP0 clock rate for RK3399_ |
| ✅  | `00185-linux-1002-for-libreelec` | `(+5/-0)[1M]` | a07efca9917949d22430f16fb7235fe10e262624 `rk3328-a1.dts` | `Alex Bee` _arm64: dts: rockchip: Enable USB3 for rk3328 Beelink A1_ |
| ✅  | `00185-linux-1002-for-libreelec` | `(+4/-4)[1M]` | bcd1572a0b3a2f122ee2b763d4b2ca4cc1f421f5 `dw-hdmi-i2s-audio.c` | `Alex Bee` _WIP: drm: bridge: dw-hdmi: switch from .hw_parmas to .prepare for i2s_ |
| ✅  | `00185-linux-1002-for-libreelec` | `(+3/-3)[1M]` | 29db810d8af0bbe3238c9d820db665e537fa9190 `rk3399-roc-pc.dtsi` | `Alex Bee` _arm64: dts: rockchip: Disbake fusb for rk3399-roc-pc_ |
| ✅  | `00186-linux-2000-v4l2-wip-rkvdec-hevc` | `(+2647/-2)[4M, 1A]` | c2da3cbcb73402a6b89523c4f12c7aea81ad57f8 `rkvdec-hevc.c`, `rkvdec.c`, `Makefile`, `rkvdec-regs.h`, `rkvdec.h` | `Jonas Karlman` _WIP: media: rkvdec: add HEVC backend_ |
| ✅  | `00186-linux-2000-v4l2-wip-rkvdec-hevc` | `(+85/-30)[2M]` | 414543a864e36896f536a651222da74e1c20fc6a `rkvdec.c`, `rkvdec.h` | `Alex Bee` _media: rkvdec: add variants support_ |
| ✅  | `00186-linux-2000-v4l2-wip-rkvdec-hevc` | `(+8/-0)[1M]` | 6fa3a992ef5c9dcd764f90f9d0fd2142b7aad5b5 `rkvdec.c` | `Alex Bee` _media: rkvdec: add RK3288 variant_ |
| ✅  | `00186-linux-2000-v4l2-wip-rkvdec-hevc` | `(+20/-1)[1M]` | 2f7637f891fac0908676a6e88f2a51400f79829e `rk3288.dtsi` | `Alex Bee` _ARM: dts: RK3288: add hevc node_ |
| ✅  | `00186-linux-2000-v4l2-wip-rkvdec-hevc` | `(+23/-3)[1M]` | 7838e3b55f11e721fbad2091ca968779c31b63b2 `rkvdec-hevc.c` | `Nicolas Dufresne` _media: rkvdec: Fix HEVC RPS bit offsets_ |
| ✅  | `00186-linux-2000-v4l2-wip-rkvdec-hevc` | `(+4/-2)[1M]` | efc65aa474a80127857df4b084c0d9cbd7ac6a46 `rkvdec-hevc.c` | `Nicolas Dufresne` _media: rkvdec: Fix number of HEVC references being set in RPS_ |
| ✅  | `00187-linux-2001-v4l2-wip-iep-driver` | `(+73/-0)[1A]` | e41b4535d5accd3c8b9d151f50cdc854b3090c85 `rockchip-iep.yaml` | `Alex Bee` _dt-bindings: media: Add Rockchip IEP binding_ |
| ✅  | `00187-linux-2001-v4l2-wip-iep-driver` | `(+1515/-0)[2M, 5A]` | ed9ec95592eb34501071e67cd7b97312ece4cca2 `iep.c`, `iep-regs.h`, `iep.h`, `Kconfig`, `Makefile` | `Alex Bee` _media: rockchip: Add Rockchip IEP driver_ |
| ✅  | `00187-linux-2001-v4l2-wip-iep-driver` | `(+22/-0)[1M]` | b4a50ec0ac723ce8b8e8da7e7ecfdf25e96f5152 `rk3328.dtsi` | `Alex Bee` _ARM64: dts: rockchip: Add IEP node for RK3328_ |
| ✅  | `00187-linux-2001-v4l2-wip-iep-driver` | `(+12/-1)[1M]` | 433ca4bdf3db0febe59e0d69536dfdd02acf6657 `rk3399.dtsi` | `Alex Bee` _ARM64: dts: rockchip: Add IEP node for RK3399_ |
| ✅  | `00187-linux-2001-v4l2-wip-iep-driver` | `(+12/-1)[1M]` | c60996a5fb51f21ef49ee157bdb6e74465ffad5a `rk3288.dtsi` | `Alex Bee` _ARM: dts: rockchip: Add IEP node for RK3288_ |
| ✅  | `00190-linux-90100-add-clock` | `(+2/-1)[2M]` | 047a0b9be8248caa6bebe275c95deef8278eb6d7 `clk-rk3399.c`, `rk3399-cru.h` | `Piotr Szczepanik` _[ARCHEOLOGY] Fixed sound from rt5651 on OrangePi 4 (#1870)_ |
| ✅  | `00200-linux-90101-add-rt5651-konf` | `(+9/-0)[1M]` | 67c37a429d16c8ac5963075075b11e2bdd1341fc `Kconfig` | `Oleg` _[ARCHEOLOGY] move kernel media edge to 5.17 (#3704)_ |
| ✅  | `00210-linux-90102-rt5651` | `(+17/-0)[2M]` | f01f92278dbfa88e658339818e6aac0547f8eded `rt5651.c`, `rt5651.h` | `Piotr Szczepanik` _[ARCHEOLOGY] Fixed sound from rt5651 on OrangePi 4 (#1870)_ |
| ✅  | `00220-linux-90103-nanopc-t4-5651` | `(+108/-9)[1M]` | 540a9f9828982fc32e46b21f732b6545823fff86 `rk3399-nanopi4.dtsi` | `Oleg` _[ARCHEOLOGY] move kernel edge to 5.16 (#3387)_ |
| ✅  | `00230-linux-90104-all-codec` | `(+0/-1)[1M]` | a26566eca2196108818356e839b583b57cd85f51 `Kconfig` | `Oleg` _[ARCHEOLOGY] move kernel media edge to 5.17 (#3704)_ |
| ✅  | `00240-linux-90117-add-rk3399-roc-pc-plus-sound` | `(+114/-0)[1M]` | ff089a9b633527553e1b986e78451d4efa5a2983 `es8328.c` | `Oleg` _[ARCHEOLOGY] fix analog sound station-p1 (#3166)_ |
| ✅  | `00250-linux-90200-rk3328-roc-pc-wifi-fix` | `(+15/-1)[1M]` | e24c486023438bcf30efbbe68696042cff690e50 `rk3328-roc-pc.dts` | `Oleg` _[ARCHEOLOGY] move kernel edge to 5.16 (#3387)_ |
| ✅  | `00270-add-rk3328-usb3-phy-driver` | `(+1350/-0)[6M, 2A]` | 7d61b4038c44ac9514a06fa6ea815ba6be8c67d2 `phy-rockchip-inno-usb3.c`, `phy-rockchip-inno-usb3.yaml`, `rk3328.dtsi`, `rk3328-roc-cc.dts`, `rk3328-rock64.dts`, `Kconfig`, `grf.yaml`, `Makefile` | `tonymac32` _[ARCHEOLOGY] [ rockchip64 ] add USB3 PHY RK3328_ |
| ✅  | `00290-board-roc-rk3399-pc-fix-fusb302-compatible` | `(+2/-2)[1M]` | 112c61be83cb650a03a91b7af4317ba431e94f21 `rk3399-roc-pc.dtsi` | `tonymac32` _[ARCHEOLOGY] [ Rockchip64 Current ] RK3399-ROC-PC power fix_ |
| ✅  | `00300-general-add-dwc3-xhci-usb-trb-quirk` | `(+35/-1)[6M]` | c5ea05c887cacf3a61c997c0aaf545bd6569978d `xhci-ring.c`, `host.c`, `xhci.h`, `core.h`, `xhci-plat.c`, `core.c` | `Aditya Prayoga` _[ARCHEOLOGY] Fix 2.5G Ethernet on Helios64 Mainline kernel (#2567)_ |
| ✅  | `00310-general-add-miniDP-dt-doc` | `(+66/-0)[1A]` | f88abb363e9a40ec8dbe6ff5c991a69a43d46019 `extcon-usbc-virtual-pd.yaml` | `Tony` _[ARCHEOLOGY] RK3399 Typec DP (#2676)_ |
| ✅  | `00320-general-add-miniDP-virtual-extcon` | `(+302/-0)[3M, 1A]` | 5a3941bc6c9976dbc3748291a3ff37312a95b989 `extcon-usbc-virtual-pd.c`, `Kconfig`, `MAINTAINERS`, `Makefile` | `Tony` _[ARCHEOLOGY] RK3399 Typec DP (#2676)_ |
| ✅  | `00330-general-add-overlay-compilation-support` | `(+35/-1)[3M]` | 9d963f0e034b5b5e99fe8e40942f32321587c21c `Makefile.lib`, `Makefile.dtbinst`, `.gitignore` | `zador-blood-stained` _[ARCHEOLOGY] Rename, split and improve H3 DT overlays_ |
| ✅  | `00340-general-add-overlay-configfs` | `(+329/-0)[2M, 2A]` | cf7c17951e64ddaf4b3107d33e634d62e5afbdff `configfs.c`, `configfs-overlays.txt`, `Kconfig`, `Makefile` | `Pantelis Antoniou` _OF: DT-Overlay configfs interface_ |
| ✅  | `00355-general-add-panel-simple-dsi` | `(+773/-0)[1M, 1A]` | 04141152c66f26f888d246e4cc45aa6cf7d40959 `panel-simple-dsi.c`, `Makefile` | `simple` _[ARCHEOLOGY] general add panel simple dsi (#3140)_ |
| ✅  | `00400-general-fix-es8316-kernel-panic` | `(+1/-1)[1M]` | 12680fbbc2eeec9218ac686ba0c0eace2e2e110f `es8316.c` | `Yannick Adam` _[ARCHEOLOGY] Enable es8316 on RockPi4 (#1885)_ |
| ✅  | `00410-general-increasing_DMA_block_memory_allocation_to_2048` | `(+3/-5)[1M]` | fa8f733ae01698547be26a59582ba2e91fd90f15 `pool.c` | `Igor Pecovnik` _[ARCHEOLOGY] Increasing DMA block memory allocation to 2048k on all relevant kernels._ |
| ✅  | `00420-general-possibility-of-disabling-rk808-rtc` | `(+2/-1)[2M]` | fbb2c68c4f6c0b73cd6f7d675e49ebb5f6b25149 `mfd-core.c`, `rk808.c` | `Piotr Szczepanik` _add possibility of disabling rk808-rtc_ |
| ✅  | `00430-general-rk808-configurable-switch-voltage-steps` | `(+13/-4)[1M]` | 799de4c9a61346f7d85e05130d9811d7b69c3a45 `rk808-regulator.c` | `Piotr Szczepanik` _[ARCHEOLOGY] NanoPi M4V2 stability fix for current and dev (#2663)_ |
| ✅  | `00440-general-workaround-broadcom-bt-serdev` | `(+1/-1)[1M]` | 38b607b29376afe0e05549e97247f3d99833bcaa `btbcm.c` | `Paolo Sabatino` _Workaround to make several broadcom bluetooth serdev devices work even without proper MAC address_ |
| ✅  | `00450-rk3328-dtsi-usb3-reset-properties` | `(+2/-0)[1M]` | ad734f4ff1008223e0ad4364e8a2c118bc1950a5 `rk3328.dtsi` | `Paolo Sabatino` _usb3 reset properties_ |
| ✅  | `00460-rk3328-roc-pc-bt` | `(+15/-0)[1M]` | c58933634573b43ba46b486d395a757246d47b94 `rk3328-roc-pc.dts` | `Oleg` _[ARCHEOLOGY] fix emmc nano-pc-t4 (#3557)_ |
| ✅  | `00470-rk3399-enable-dwc3-xhci-usb-trb-quirk` | `(+2/-0)[1M]` | dedbfae40a3be58c24c3b3cea469f584cdc08b6d `rk3399.dtsi` | `Aditya Prayoga` _[ARCHEOLOGY] Fix 2.5G Ethernet on Helios64 Mainline kernel (#2567)_ |
| ✅  | `00480-rk3399-nanopc-t4-emmc` | `(+4/-4)[1M]` | f1a98aae7c8df162070787ee8cecc2d9972b2c99 `rk3399-nanopc-t4.dts` | `Oleg` _[ARCHEOLOGY] fix emmc nano-pc-t4 (#3557)_ |
| ✅  | `00490-rk3399-pci-rockchip-support-ep-gpio-undefined-case` | `(+1/-2)[1M]` | 3a763df223cc393693f52b5f2135c3bb41b37b88 `pcie-rockchip.c` | `Igor Pecovnik` _oo_ |
| ✅  | `00500-rk3399-rp64-pcie-Reimplement-rockchip-PCIe-bus-scan-delay` | `(+41/-0)[4M]` | cf12db46de561714959e2dc0c777cdd4f66f0b15 `pcie-rockchip-host.c`, `kernel-parameters.txt`, `pcie-rockchip.c`, `pcie-rockchip.h` | `Dan Pasanen` _[ARCHEOLOGY] rockchip-[current,edge]: add pcie hack and lsi scsi/sas support (#3351)_ |
| ✅  | `00510-rk3399-sd-drive-level-8ma` | `(+8/-8)[1M]` | cd8e60e64b93a72c69864184fafaec4ad2b4fcfb `rk3399.dtsi` | `Martin Ayotte` _[ARCHEOLOGY] add better strength on SDCard and put back previous speed setting_ |
| ✅  | `00520-rk3399-unlock-temperature` | `(+3/-3)[1M]` | 06575e297380cd550cc141b8e67d1fd19d2f1d00 `rk3399.dtsi` | `ThomasKaiser` _[ARCHEOLOGY] Increase performance with rk3399-dev_ |
| ✅  | `00540-fix-analog-sound-rk3399-roc-pc-plus-dts` | `(+4/-0)[1M]` | 69213fbae640b8a42caaa0a4b59c029f5b330d15 `rk3399-roc-pc-plus.dts` | `Oleg` _[ARCHEOLOGY] fix Station P1 (#4796)_ |


