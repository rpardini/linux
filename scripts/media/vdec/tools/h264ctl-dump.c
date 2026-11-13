/* LD_PRELOAD shim: dump V4L2 stateless H.264 + AV1 controls set by any app (FFmpeg, GStreamer).
 * Output to $H264DUMP (default stderr). One line per decode_params, SPS/PPS as hex when changed. */
#define _GNU_SOURCE
#include <dlfcn.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <linux/videodev2.h>
#include <linux/v4l2-controls.h>

static FILE *out;
static unsigned char last_sps[sizeof(struct v4l2_ctrl_h264_sps)], last_pps[sizeof(struct v4l2_ctrl_h264_pps)];
static int n;

static void hex(const char *tag, const void *p, size_t len, unsigned char *last)
{
	if (!memcmp(p, last, len)) return;
	memcpy(last, p, len);
	fprintf(out, "%s", tag);
	for (size_t i = 0; i < len; i++) fprintf(out, "%02x", ((const unsigned char *)p)[i]);
	fprintf(out, "\n");
}

static void dump(struct v4l2_ext_controls *c)
{
	for (unsigned i = 0; i < c->count; i++) {
		struct v4l2_ext_control *e = &c->controls[i];
		if (e->id == V4L2_CID_STATELESS_H264_SPS) hex("SPS ", e->ptr, sizeof(struct v4l2_ctrl_h264_sps), last_sps);
		else if (e->id == V4L2_CID_STATELESS_H264_PPS) hex("PPS ", e->ptr, sizeof(struct v4l2_ctrl_h264_pps), last_pps);
		else if (e->id == V4L2_CID_STATELESS_AV1_FRAME) {
			const struct v4l2_ctrl_av1_frame *f = e->ptr;
			const struct v4l2_av1_tile_info *t = &f->tile_info;
			fprintf(out, "AV1F %d type=%u %ux%u flags=0x%x show=%d tiles=%ux%u ctx_id=%u tsb=%u cols=",
				n++, f->frame_type, f->frame_width_minus_1 + 1, f->frame_height_minus_1 + 1, f->flags,
				!!(f->flags & V4L2_AV1_FRAME_FLAG_SHOW_FRAME), t->tile_cols, t->tile_rows,
				t->context_update_tile_id, t->tile_size_bytes);
			for (int j = 0; j <= t->tile_cols && j <= V4L2_AV1_MAX_TILE_COLS; j++)
				fprintf(out, "%u%s", t->mi_col_starts[j], j < t->tile_cols ? "," : "");
			fprintf(out, " rows=");
			for (int j = 0; j <= t->tile_rows && j <= V4L2_AV1_MAX_TILE_ROWS; j++)
				fprintf(out, "%u%s", t->mi_row_starts[j], j < t->tile_rows ? "," : "");
			fprintf(out, " wsb=");
			for (int j = 0; j < t->tile_cols && j < V4L2_AV1_MAX_TILE_COLS; j++)
				fprintf(out, "%u,", t->width_in_sbs_minus_1[j]);
			fprintf(out, " hsb=");
			for (int j = 0; j < t->tile_rows && j < V4L2_AV1_MAX_TILE_ROWS; j++)
				fprintf(out, "%u,", t->height_in_sbs_minus_1[j]);
			fprintf(out, "\n");
		} else if (e->id == V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY) {
			const struct v4l2_ctrl_av1_tile_group_entry *g = e->ptr;
			unsigned cnt = e->size / sizeof(*g);
			fprintf(out, "AV1TG n=%u:", cnt);
			for (unsigned j = 0; j < cnt && j < 64; j++)
				fprintf(out, " [r%u c%u off=%u sz=%u]", g[j].tile_row, g[j].tile_col, g[j].tile_offset, g[j].tile_size);
			fprintf(out, "\n");
		}
		else if (e->id == V4L2_CID_STATELESS_H264_DECODE_PARAMS) {
			const struct v4l2_ctrl_h264_decode_params *d = e->ptr;
			fprintf(out, "DP %d fn=%u poc=%d/%d ref_idc=%u flags=0x%x idr=%u lsb=%u dpoc=%d,%d,%d marking=%u pocbits=%u |",
				n++, d->frame_num, d->top_field_order_cnt, d->bottom_field_order_cnt, d->nal_ref_idc, d->flags,
				d->idr_pic_id, d->pic_order_cnt_lsb, d->delta_pic_order_cnt_bottom, d->delta_pic_order_cnt0,
				d->delta_pic_order_cnt1, d->dec_ref_pic_marking_bit_size, d->pic_order_cnt_bit_size);
			for (int j = 0; j < V4L2_H264_NUM_DPB_ENTRIES; j++) {
				const struct v4l2_h264_dpb_entry *x = &d->dpb[j];
				if (!(x->flags & V4L2_H264_DPB_ENTRY_FLAG_VALID)) continue;
				fprintf(out, " [poc=%d/%d fn=%u pn=%u fl=0x%x f=%u]", x->top_field_order_cnt,
					x->bottom_field_order_cnt, x->frame_num, x->pic_num, x->flags, x->fields);
			}
			fprintf(out, "\n");
		}
	}
	fflush(out);
}

int ioctl(int fd, unsigned long req, ...)
{
	static int (*real)(int, unsigned long, ...);
	va_list ap; va_start(ap, req); void *arg = va_arg(ap, void *); va_end(ap);
	if (!real) real = dlsym(RTLD_NEXT, "ioctl");
	if (!out) { const char *f = getenv("H264DUMP"); out = f ? fopen(f, "w") : stderr; if (!out) out = stderr; }
	if (req == VIDIOC_S_EXT_CTRLS && arg) dump(arg);
	if (req == VIDIOC_S_FMT && arg) {
		const struct v4l2_format *f = arg;
		if (V4L2_TYPE_IS_MULTIPLANAR(f->type))
			fprintf(out, "S_FMT type=%u %ux%u fourcc=%.4s planes=%u bpl0=%u si0=%u si1=%u\n", f->type,
				f->fmt.pix_mp.width, f->fmt.pix_mp.height, (const char *)&f->fmt.pix_mp.pixelformat,
				f->fmt.pix_mp.num_planes, f->fmt.pix_mp.plane_fmt[0].bytesperline,
				f->fmt.pix_mp.plane_fmt[0].sizeimage, f->fmt.pix_mp.plane_fmt[1].sizeimage), fflush(out);
	}
	if (req == VIDIOC_REQBUFS && arg) {
		const struct v4l2_requestbuffers *r = arg;
		fprintf(out, "REQBUFS type=%u count=%u mem=%u\n", r->type, r->count, r->memory), fflush(out);
	}
	if ((req == VIDIOC_STREAMON || req == VIDIOC_STREAMOFF) && arg)
		fprintf(out, "%s type=%u\n", req == VIDIOC_STREAMON ? "STREAMON" : "STREAMOFF", *(const int *)arg), fflush(out);
	if (req == VIDIOC_QBUF && arg) {
		const struct v4l2_buffer *b = arg;
		if (b->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE && b->m.planes)
			fprintf(out, "QBUF-OUT idx=%u bytesused=%u ts=%llu\n", b->index, b->m.planes[0].bytesused,
				(unsigned long long)b->timestamp.tv_sec * 1000000000ULL + b->timestamp.tv_usec * 1000ULL),
			fflush(out);
	}
	return real(fd, req, arg);
}
