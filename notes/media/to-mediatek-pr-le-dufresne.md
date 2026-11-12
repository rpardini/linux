# MT8195/MT8395 (Genio 1200, Radxa NIO-12L) HW decode in Kodi: status

Setup: mainline 7.3.4 (Armbian `genio` edge), FFmpeg 9.0.2 with v4l2-request (chewitt `armsoc-9.0.2` + MTK patches), Kodi 22 (Piers), Mesa 26.1 (panfrost), all in a container.

## Kernel

- **"One frame then hang" (MDP3 / DirectToPlane) was a mainline regression.** Only part of [Jason-JH Lin's GCE pm_runtime series v2](https://lore.kernel.org/all/20250829091727.3745415-1-jason-jh.lin@mediatek.com/) was merged: 1/3 (`3f39f5652037`, v6.18) removed pm_runtime from `cmdq_mbox_send_data`. The MDP3 part, [3/3](https://lore.kernel.org/all/20250829091727.3745415-4-jason-jh.lin@mediatek.com/), never landed, so MDP3 submits to an autosuspended GCE and the job never completes.
  - Carrying 3/3 fixes it (soak tested, ~210 fps 1080p MM21→UYVY). It should probably go back to the list with `Fixes: 3f39f5652037`.
- Also carried: Kyrie Wu's vcodec "guard empty stateless capture queue" (Genio tree; it fixes a NULL deref panic in `vb2_buffer_done` on AV1 SVC vectors), and chewitt's vb2-dma-contig cache maintenance fix for non-coherent buffers (from LibreELEC).
- SCP and SOF firmware come from linux-firmware (`mediatek/mt8195/scp.img`, `mediatek/sof/sof-mt8195.ri`, `sof-tplg/sof-mt8195.tplg`). HDMI audio works (`sof-mt8395-evk`, DL10).

## FFmpeg (v4l2-request), fixes found by diffing controls against GStreamer

- H.264: DPB `pic_num` wasn't FrameNumWrap after `frame_num` wraps, and `dec_ref_pic_marking_bit_size` was stale on non-reference slices. Together they corrupted every libx264 B-frame stream. JVT conformance 96 → 100/135.
- AV1: `mi_col_starts`/`mi_row_starts` were passed in superblock units instead of MI units, so every multi-tile frame IOMMU-faulted. Chromium AV1 8-bit 6 → 10/13, 10-bit 10 → 22/23 (same as GStreamer).
- MM21 and **MT2110T/R CPU detile on `hwdownload`**, ported from your GStreamer `unpack_MT2110T/R` (credited). It's bit-exact against software decoding, and 4K 10-bit runs at ~100 fps.
- libdrm 2.4.124 (Debian trixie) lacks the MTK modifiers, which silently compiled MM21 out. We added fallback defines (FFmpeg and Kodi).
- Conformance now (FFmpeg): H.264 100/135, HEVC 142/147, VP9 204/305, AV1 201/242. Still open: AV1 `sizeup` (faults), film grain, VP8 `segmentation-1425/1436`, HEVC `CONFWIN_A`.

## Kodi

- Both render paths work: EGL (panfrost imports 16L32S directly) and DirectToPlane (MDP3 `scale_v4l2m2m` → UYVY plane).
- 8-bit H.264/HEVC/VP9/AV1 play at full rate up to 4K60, including 150 Mbps 4K AVC (Jellyfin test set, Big Buck Bunny). Refresh switching, seeking and audio work too.
- **10-bit**: HW decode, then CPU MT2110 detile into a P010 DMA buffer, then GLES. 4K60 HEVC 10-bit / HDR10 / DV 8.1 play at full rate; AV1 10-bit 4K at ~44/60. A software fallback remains for the rest.
- No HDR output yet (the test sink has no HDR).

## MDP3 10-bit (your "mapping is missing" comment)

- Mainline already has `MDP_COLOR_420_BLK_10_V/_H` and `rdma_support_10bit` for MT8195. Adding MT2110T/R V4L2 entries is trivial.
- But the SCP firmware (`cherry_scp_v2.0.23042`) **watchdogs** on 10-bit block input (the MDP3 frame setup runs in the SCP). Its "10bit mode" update covers only the decoder side. The Genio AIoT SCP fw is older.
- MediaTek's Genio BSP kernel (`mtk-v6.6`) computes MDP3 frame setup on the AP (`mdp_alg_*`), and that code handles 10-bit block input. So the HW supports it, but mainline would need either a newer SCP fw or that AP-side code. Parked for now; the CPU detile covers it.

## Next

- Leftover conformance diffs. Packaging: Armbian, LibreELEC (kernel 7.3 + the above), [LibreELEC PR #10891](https://github.com/LibreELEC/LibreELEC.tv/pull/10891).
- Upstreaming the FFmpeg fixes, and pinging/resending the MDP3 GCE pm_runtime patch.
