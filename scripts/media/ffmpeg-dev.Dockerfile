# FFmpeg build env: trixie + trixie-backports linux-libc-dev (V4L2 stateless uAPI), as kodi-rockchip-deb's v4l2requests stage.
# Used by scripts/50-media-ffmpeg-build.sh (source and build dirs are bind-mounted; nothing is built into the image).
FROM debian:trixie
RUN printf 'Types: deb\nURIs: http://deb.debian.org/debian\nSuites: trixie-backports\nComponents: main\nSigned-By: /usr/share/keyrings/debian-archive-keyring.pgp\n' \
		> /etc/apt/sources.list.d/trixie-backports.sources && \
	printf 'Package: linux-libc-dev\nPin: release n=trixie-backports\nPin-Priority: 990\n' > /etc/apt/preferences.d/linux-libc-dev-backports && \
	apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
		build-essential nasm pkg-config ccache linux-libc-dev libdrm-dev libudev-dev libdav1d-dev libgnutls28-dev zlib1g-dev && \
	rm -rf /var/lib/apt/lists/*
