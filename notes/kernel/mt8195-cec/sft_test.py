#!/usr/bin/python3
# Measure CEC signal free time between back-to-back own transmits on /dev/cec0,
# optionally after writing a test value into the MT8195 CEC TX_ARB register.
# Usage: sft_test.py [tx_arb_hex]
import fcntl, mmap, os, struct, subprocess, sys, time, select

CEC_BASE, TX_ARB = 0x10014000, 0x2c
MSG_FMT = "=QQIIII16sBBBBBBB"          # struct cec_msg (55 bytes, padded to 56)
MSG_SZ = 56

def iowr(nr, size):
    return (3 << 30) | (size << 16) | (ord('a') << 8) | nr

CEC_TRANSMIT, CEC_RECEIVE = iowr(5, MSG_SZ), iowr(6, MSG_SZ)

def configured():
    out = subprocess.run(["cec-ctl", "-d0"], capture_output=True, text=True).stdout
    for l in out.splitlines():
        if "Logical Address Mask" in l:
            return int(l.split(":")[1], 16) != 0
    return False

def reg(val=None):
    if not configured():               # clocks gated when unconfigured: never touch
        sys.exit("adapter not configured, refusing to touch registers")
    f = os.open("/dev/mem", os.O_RDWR | os.O_SYNC)
    m = mmap.mmap(f, 0x1000, mmap.MAP_SHARED, mmap.PROT_READ | mmap.PROT_WRITE, offset=CEC_BASE)
    if val is not None:
        struct.pack_into("<I", m, TX_ARB, val)
    v = struct.unpack_from("<I", m, TX_ARB)[0]
    m.close(); os.close(f)
    return v

def pack(msg):
    b = struct.pack(MSG_FMT, 0, 0, len(msg), 0, 0, 0, bytes(msg).ljust(16, b"\0"), 0, 0, 0, 0, 0, 0, 0)
    return bytearray(b.ljust(MSG_SZ, b"\0"))

if len(sys.argv) > 1:
    print("TX_ARB set to", hex(reg(int(sys.argv[1], 16))))
else:
    print("TX_ARB is", hex(reg()))

fd = os.open("/dev/cec0", os.O_RDWR | os.O_NONBLOCK)
msg = [0x4f, 0x84, 0x10, 0x00, 0x04]   # broadcast REPORT_PHYSICAL_ADDR 1.0.0.0, playback
N = 15
for _ in range(N):
    fcntl.ioctl(fd, CEC_TRANSMIT, pack(msg))
done, deadline = [], time.time() + 10
while len(done) < N and time.time() < deadline:
    select.select([fd], [], [], 1)
    try:
        b = bytearray(MSG_SZ)
        fcntl.ioctl(fd, CEC_RECEIVE, b)
    except OSError:
        continue
    tx_ts, rx_ts, ln, _, seq, _, data, _, rxs, txs, arb, nack, low, err = struct.unpack(MSG_FMT, b[:55])
    if tx_ts:
        done.append((tx_ts, ln, txs, arb, nack, low, err))
os.close(fd)

hist = {}
for (t0, *_), (t1, ln, *_ ) in zip(done, done[1:]):
    delta = t1 - t0 - (ln * 24000000 + 4500000)
    sft = delta // 2400000
    hist[sft] = hist.get(sft, 0) + 1
print("tx results:", len(done), "status:", sorted({d[2] for d in done}),
      "arb/nack/low/err:", [sum(d[i] for d in done) for i in (3, 4, 5, 6)])
print("SFT histogram (bit periods: count):", dict(sorted(hist.items())))
