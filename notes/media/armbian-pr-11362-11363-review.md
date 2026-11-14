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
