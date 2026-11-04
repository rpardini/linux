# TODO: Iris recovery patch follow-ups (CodeRabbit review on armbian/build#11221)

The patch in question is `media: iris: reload firmware when a session stops responding`:
- kernel commit `2f1f6ab852f69`
- Armbian file `patch/kernel/archive/sc8280xp-edge/0303-media-iris-reload-firmware-when-a-session-stops-responding.patch`

All three findings were answered on the PR threads (r4474793867, r4474794082, r4474794302). No code has changed yet. All three races already exist in upstream's HFI `SYS_ERROR` recovery path (gen1 `sys_event_notify`, gen2); the patch only adds a new trigger.

## 1. An open during recovery skips teardown: fix this

- **Bug:** `iris_core_init()` (`iris_core.c` ~84) handles `IRIS_CORE_ERROR` with `goto error`, and that label sets `IRIS_CORE_DEINIT` (~128). An `open()` arriving before `sys_error_handler` runs therefore flips ERROR to DEINIT. The worker's `iris_core_deinit()` then skips the firmware unload, power-off and queue teardown, and re-inits on top of the live firmware: queues leak, and PAS auth likely fails, so the codec stays dead.
- **Constraint:** "ERROR → DEINIT on the next open" is also the retry path after core-init failures that schedule no worker:
  - gen1 `sys_init_done` error (`iris_hfi_gen1_response.c` ~287)
  - gen2 `handle_system_init` (~299)
  - `iris_wait_for_system_response()` timeout (`iris_core.c` ~51/69)

  So keep that path.
- **Planned fix:** in the ERROR branch, under `core->lock`:
  ```c
  } else if (core->state == IRIS_CORE_ERROR) {
  	ret = -EINVAL;
  	if (work_busy(&core->sys_error_handler.work)) {
  		ret = -EBUSY;	/* recovery pending/running will tear down and re-init */
  		goto exit;
  	}
  	goto error;
  }
  ```
  `work_busy()` reports PENDING while the delayed work is queued, and RUNNING once it has started but before `iris_core_deinit()` takes `core->lock`. Opens that land between the worker's deinit and init see DEINIT and init normally; the worker's init then sees INIT and returns 0.
- **Test:** trigger the wedge (`ffmpeg -c:v hevc_v4l2m2m -i src265.mp4 -f null -`) and immediately loop opens (e.g. `v4l2-ctl -d /dev/video0 --all` in a tight loop). Check that recovery still reloads the firmware (no leaked queues, no PAS -22), then that GStreamer HEVC is still bit-exact.

## 2. Wake clients blocked in DQBUF: optional, needs a close-order change

- **Hang:** a peer blocked in a blocking `VIDIOC_DQBUF` waits forever once recovery discards its session.
- **Why the naive fix is unsafe:** calling `iris_vb2_queue_error()` (`iris_buffer.c` ~830) while walking `core->instances` is a use-after-free risk. `iris_close()` (`iris_vidc.c` ~287) runs `v4l2_m2m_ctx_release()` *before* `iris_remove_session()` takes the instance off the list.
- **If doing it:**
  - move `iris_remove_session()` before `v4l2_m2m_ctx_release()` in `iris_close()`;
  - check that `session_close` and the internal-buffer teardown don't depend on list membership (`iris_get_instance()` lookups from the response handler would then miss the closing instance; that's probably fine, since its responses are no longer needed);
  - then call `iris_vb2_queue_error()` per instance in `iris_core_recover()`.
- Better proposed upstream together with the existing sys-error path.

## 3. Unlocked peer state change: mitigate with a reset generation counter

- **Race:** `iris_core_recover()` marks peers ERROR under `core->lock` only. A concurrent stream-on can overwrite ERROR with a streaming state.
- **Why the naive fix deadlocks:** the established lock order is `inst->lock` → `core->lock` (`iris_hfi_queue_cmd_write()`), so taking each peer's lock under `core->lock` reverses it.
- **Realistic effect:** the stale peer's next command times out against the fresh firmware, which triggers a second reset and kills healthy sessions.
- **Lock-free mitigation:**
  - add `u32 reset_gen` to `struct iris_core`, incremented in `iris_core_recover()` (and in the sys-error handler);
  - add `u32 core_gen` to `struct iris_inst`, set when the session opens (`iris_vb2_queue_setup` → `session_open`);
  - in `iris_wait_for_session_response()`, recover only if `inst->core_gen == READ_ONCE(core->reset_gen)` and the instance wasn't already ERROR.

  Stale instances then can't trigger another reset.

## After implementing

1. Re-test on the X13s:
   - the wedge, then recovery;
   - the parallel-open stress test from #1;
   - GStreamer H.264/HEVC/VP9 bit-exact.
2. Regenerate `0303` in armbian/build, and push to the PR branch `pr/thinkpad-x13s-switch-to-BRANCHedge-many-fixes`.
3. Reply on the threads with what changed.
