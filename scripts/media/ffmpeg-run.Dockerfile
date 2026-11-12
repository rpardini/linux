# Board runtime for the FFmpeg built by 50-media-ffmpeg-build.sh: run with -v /opt/ffmpeg-vdec:/opt/ffmpeg-vdec:ro.
FROM debian:trixie
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	libdrm2 libudev1 libdav1d7 libgnutls30t64 zlib1g v4l-utils && rm -rf /var/lib/apt/lists/*
ENV PATH=/opt/ffmpeg-vdec/bin:$PATH
