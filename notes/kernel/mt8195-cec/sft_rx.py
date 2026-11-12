#!/usr/bin/python3
# Monitor /dev/cecN and report the signal free time before each message received
# from a given initiator, based on rx timestamps. Usage: sft_rx.py <dev> <initiator> <seconds>
import fcntl, os, struct, sys, time, select

MSG_FMT, MSG_SZ = "=QQIIII16sBBBBBBB", 56
CEC_RECEIVE = (3 << 30) | (MSG_SZ << 16) | (ord('a') << 8) | 6
CEC_S_MODE = (1 << 30) | (4 << 16) | (ord('a') << 8) | 9
CEC_MODE_MONITOR = 0xe0

dev, init, secs = sys.argv[1], int(sys.argv[2]), float(sys.argv[3])
fd = os.open(dev, os.O_RDWR | os.O_NONBLOCK)
fcntl.ioctl(fd, CEC_S_MODE, struct.pack("I", CEC_MODE_MONITOR))
rx, end = [], time.time() + secs
while time.time() < end:
    select.select([fd], [], [], 0.5)
    try:
        b = bytearray(MSG_SZ)
        fcntl.ioctl(fd, CEC_RECEIVE, b)
    except OSError:
        continue
    tx_ts, rx_ts, ln, _, _, _, data, *_ = struct.unpack(MSG_FMT, b[:55])
    if rx_ts:
        rx.append((rx_ts, ln, data[0] >> 4))
os.close(fd)
hist = {}
for (t0, _, i0), (t1, ln, i1) in zip(rx, rx[1:]):
    if i0 == init and i1 == init:
        sft = (t1 - t0 - (ln * 24000000 + 4500000)) // 2400000
        hist[sft] = hist.get(sft, 0) + 1
print("rx msgs:", len(rx), "from", init, ":", sum(1 for r in rx if r[2] == init))
print("SFT histogram seen by receiver (bit periods: count):", dict(sorted(hist.items())))
