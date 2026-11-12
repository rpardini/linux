# Board test image: trixie GStreamer v4l2codecs (stateless V4L2) + fluster.
# Build context = le-media-kodi-vdec/fluster (copied in as /opt/fluster).
# Built by scripts/51-media-image.sh gst-fluster; vectors live outside the image (bind-mount /vectors).
FROM debian:trixie
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	gstreamer1.0-tools gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad \
	python3 v4l-utils ca-certificates unzip xz-utils && rm -rf /var/lib/apt/lists/*
COPY . /opt/fluster
WORKDIR /opt/fluster
ENTRYPOINT ["python3", "/opt/fluster/fluster.py", "-r", "/vectors", "-tsd", "/opt/fluster/test_suites"]
