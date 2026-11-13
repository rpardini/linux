#!/bin/bash
# board-watch.sh <rc-file> [max-minutes]: exits when the run's RC file appears, or the board is unreachable,
# rebooted (uptime dropped) or has a D-state task stuck for 15 s+ (except mt6360), or after max-minutes (default 45).
# Board checked every 8 min.
RC=$1; MAX=$(( ${2:-45} * 60 )); B=${BOARD:-root@192.168.66.83}
# D-state tasks only count if the same pid is still in D 15 s later (jbd2 etc. blink into D on I/O)
up() { timeout 40 ssh -o BatchMode=yes -o ConnectTimeout=8 $B 'cut -d. -f1 /proc/uptime; a=$(ps -eo pid=,stat=,comm= | awk "\$2 ~ /D/ && \$3 !~ /mt6360/ {print \$1}"); sleep 15; for p in $a; do s=$(ps -o stat=,comm= -p $p); case "$s" in D*) echo "$p $s";; esac; done | head -3' 2>/dev/null; }
prev=$(up | head -1); [ -n "$prev" ] || { echo "BOARD UNREACHABLE at start"; exit 3; }
start=$(date +%s); last=$start
while :; do
	[ -f "$RC" ] && { echo "RUN FINISHED rc=$(cat "$RC")"; exit 0; }
	now=$(date +%s)
	(( now - start >= MAX )) && { echo "WATCH TIMEOUT ($((MAX/60)) min), run still going; board uptime ${prev}s"; exit 0; }
	if (( now - last >= 480 )); then
		last=$now; out=$(up); cur=$(echo "$out" | head -1); d=$(echo "$out" | tail -n +2)
		[ -z "$cur" ] && { echo "BOARD UNREACHABLE at $(date +%T)"; exit 3; }
		(( cur < prev )) && { echo "BOARD REBOOTED (uptime ${cur}s < ${prev}s) at $(date +%T)"; exit 3; }
		[ -n "$d" ] && { echo "D-STATE TASK at $(date +%T): $d"; exit 3; }
		echo "$(date +%T) board ok, uptime ${cur}s"; prev=$cur
	fi
	sleep 15
done
