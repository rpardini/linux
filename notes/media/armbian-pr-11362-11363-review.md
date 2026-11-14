# Armbian PRs #11362 (CEC) / #11363 (MDP3): CodeRabbit review, 2026-11-14

All 5 findings were checked against the code and fixed (see the plan's resume block, `notes/kernel/mt8195-cec.md`, STATUS K23/K29). Igor approved #11362 and left no comments. The draft replies below were **not posted**; the user posts them, or they're posted with gh after an OK.


## Reply: #11362 — 3101 line 373 (deadlock)
Confirmed: `cec_adap_enable()` calls `adap_enable(false)` with `adap->lock` held, and the IRQ thread takes it in `cec_received_msg()`. Fixed: power off uses `disable_irq_nosync()`, and the IRQ thread returns early when the controller is powered off (`cec->enabled` checked under the spinlock), so it never touches gated registers. Shutdown order unchanged (hrtimer cancel → mask/PDN under the lock → clocks off).

## Reply: #11362 — 3101 line 409 (log_addr while powered off)
Agreed. The address is still cached and only programmed while powered (hw_init writes it on power on). `adap_transmit()` got the same guard (returns -EIO; the core aborts the message).

## Reply: #11362 — 3101 line 566 (polling messages and bus_free)
Agreed. `bus_free` is now updated for every received message (`CEC_RX_BUF_READY`), polls included; only non-empty messages go to the core.

## Reply: #11363 — 3200 line 47 (PM ref on mbox_send_message failure)
Agreed. Packets that were not submitted drop their GCE PM reference (no callback will run for them).

## Reply: #11363 — 3200 line 51 (pm get failure after cmd[0] was submitted)
Agreed. The PM references for all pipes are taken before the first `mbox_send_message()`, and released if one fails, so `err_clock_off` only sees unsubmitted commands. The same pattern on an `mbox_send_message()` failure for pipe 1 is pre-existing mainline code and out of scope here. Noted in the patch as `[rpardini: ...]`; this is also what would go upstream as the resend of Jason-JH Lin's 3/3.

# Round 2 (after the re-cut; CodeRabbit "full review", 2026-11-14 ~13:40)

4 new findings. 3 on CEC, all valid and fixed in K23 patch 2 (backup `b4/mt8195-cec-backup-pre-cr2`; Armbian `3101` + body bullets, backup `backup/extensions-pre-cr2`; LE `3101` in `b32b291ea6`). The vb2 one is not changed (user's decision).

## Reply: #11362 — 3101 ~line 606 (report TX before RX)
Agreed, `cec-core.rst` asks for exactly that. `cec_transmit_attempt_done()` is now called before `cec_received_msg()`.

## Reply: #11362 — 3101 line 688 (drain the IRQ thread before unregistering)
Agreed. `remove()` now does `disable_irq()` (synchronous, outside `adap->lock`) before unregistering the adapter, so the thread can't run on a freed adapter. Power off keeps `disable_irq_nosync()`.

## Reply: #11362 — 3101 ~line 696 (serialize suspend against adapter disable)
Agreed. I went a bit further than suggested: a driver mutex now serializes `adap_enable`, suspend and resume, which also covers power on vs resume. There's a `suspended` flag: an enable or disable that arrives while suspended is only recorded, and resume applies it. `cec->enabled` stays the spinlock-protected guard for register access in the IRQ thread, the timer and the callbacks.

## Reply: #11363 — 3202 line 60 (honor the CPU access direction)
Not changing this one. It's Christian Hewitt's patch as carried by LibreELEC, and it follows what mainline `videobuf2-dma-sg` already does: `begin/end_cpu_access` sync with `buf->dma_dir`, the direction the sg_table was mapped with (`videobuf2-dma-sg.c`). As the comment itself notes, syncing with the importer's direction would mismatch the mapping direction. The stale-read case needs a foreign device writing into an OUTPUT buffer, which doesn't happen here. If it ever matters, it should be fixed in both vb2 allocators upstream.
