Thanks for all the pointers!

A quick update, as I'm back to working on Mediatek Genio (_and much better myself at handling the bots_):

- [mainline u-boot](https://github.com/armbian/build/pull/11265) (with vendor TF-A, OPTEE, libdram/libbase; based on the mainline work by BayLibre's David Lechner) going in Armbian, with several extras on top of upstream: RAM size autodetection, working USB3 Type-As (via PCIe), Ethernet/PXE, etc. Porting the whole thing to LE is not yet in scope, but it's doable now. I plan to coordinate at least some of it with dlech for upstream.
  - newcomer Rolf (& his bot) has [found and fixed u64 related problems in fastboot-rs](https://github.com/boardswarm/fastboot-rs/pull/45) / mtkflash and lk.bin (required for initial bootloader/image flash with large images) and I pestered Sjoerd et al.

- I've come up with a dev/test rig setup, complete with the auto-booting cable hack (which allows for automated power-on/off), UART logs, and an HDMI loop between the NIO-12L HDMI-TX and a RK3588 board with HDMI-RX. This has allowed me (& my bot) to:
  - port a supposedly "mainline worthy" CEC driver for MT8188/MT8195, based on the MediaTek vendor driver by Tommy Chen. With the rig I could do full CEC compliance tests, and try and catch Hans Verkuil's requirements for CEC drivers, `smash`, etc. 
  - go much further with Kodi EGL/DirectToPlane and the decoders, MDP3, etc; the bot can run Kodi on Genio and capture frames on the RK3588. See below for details (straight from the bot).

I'll let it have a few more turns on the rig, then move the board next to a TV for real human testing, then update this PR (after moving to v7.3.y).

Below the cut, bot's words (Opus 5.5). Some of it, specially the half-merged pm_runtime series, seem pretty relevant.

----------


> #### Kernel
> - **"One frame then hang" (MDP3 / DirectToPlane) was a mainline regression.** Only part of [Jason-JH Lin's GCE pm_runtime series v2](https://lore.kernel.org/all/20250829091727.3745415-1-jason-jh.lin@mediatek.com/) was merged: 1/3 (`3f39f5652037`, v6.18) removed pm_runtime from `cmdq_mbox_send_data`. The MDP3 part, [3/3](https://lore.kernel.org/all/20250829091727.3745415-4-jason-jh.lin@mediatek.com/), never landed, so MDP3 submits to an autosuspended GCE and the job never completes.
>   - Carrying 3/3 fixes it (soak tested, ~210 fps 1080p MM21→UYVY). It should probably go back to the list with `Fixes: 3f39f5652037`.
> - Also carried: Kyrie Wu's vcodec "guard empty stateless capture queue" (Genio tree; it fixes a NULL deref panic in `vb2_buffer_done` on AV1 SVC vectors), and chewitt's vb2-dma-contig cache maintenance fix for non-coherent buffers (from LibreELEC).
> 
> #### FFmpeg (v4l2-request), fixes found by diffing controls against GStreamer
> 
> - H.264: DPB `pic_num` wasn't FrameNumWrap after `frame_num` wraps, and `dec_ref_pic_marking_bit_size` was stale on non-reference slices. Together they corrupted every libx264 B-frame stream. JVT conformance 96 → 100/135.
> - AV1: `mi_col_starts`/`mi_row_starts` were passed in superblock units instead of MI units, so every multi-tile frame IOMMU-faulted. Chromium AV1 8-bit 6 → 10/13, 10-bit 10 → 22/23 (same as GStreamer).
> - MM21 and **MT2110T/R CPU detile on `hwdownload`**, ported from Dufresne's GStreamer `unpack_MT2110T/R` (credited). It's bit-exact against software decoding, and 4K 10-bit runs at ~100 fps.
> - Conformance now (FFmpeg): H.264 100/135, HEVC 142/147, VP9 204/305, AV1 201/242. Still open: AV1 `sizeup` (faults), film grain, VP8 `segmentation-1425/1436`, HEVC `CONFWIN_A`.
> 
> #### Kodi
> 
> - Both render paths work: EGL (panfrost imports 16L32S directly) and DirectToPlane (MDP3 `scale_v4l2m2m` → UYVY plane).
> - 8-bit H.264/HEVC/VP9/AV1 play at full rate up to 4K60, including 150 Mbps 4K AVC (Jellyfin test set, Big Buck Bunny). Refresh switching, seeking and audio work too.
> - **10-bit**: HW decode, then CPU MT2110 detile into a P010 DMA buffer, then GLES. 4K60 HEVC 10-bit / HDR10 / DV 8.1 play at full rate; AV1 10-bit 4K at ~44/60. A software fallback remains for the rest.
> - No HDR output yet (my test sink has no HDR).
> 
> #### MDP3 10-bit 
> 
> > "The mapping in MDP3 is indeed missing, and I don't see upstream patches on the ML. It is supported though, maybe this can be extracted from vendor TV stacks."
> 
> - Mainline already has `MDP_COLOR_420_BLK_10_V/_H` and `rdma_support_10bit` for MT8195. Adding MT2110T/R V4L2 entries is trivial.
> - But the SCP firmware (`cherry_scp_v2.0.23042`) **watchdogs** on 10-bit block input (the MDP3 frame setup runs in the SCP). Its "10bit mode" update covers only the decoder side. (I also tried The Genio AIoT SCP fw, but it is older).
> - MediaTek's Genio BSP kernel (`mtk-v6.6`) computes MDP3 frame setup on the AP (`mdp_alg_*`), and that code handles 10-bit block input. So the HW supports it, but mainline would need either a newer SCP fw or that AP-side code. Parked for now; the CPU detile covers it.

