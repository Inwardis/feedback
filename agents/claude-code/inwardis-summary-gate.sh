#!/usr/bin/env bash
# Stop — ask for a summary only when unsummarised writes have piled up.
input=$(cat)
[ "$(jq -r '.stop_hook_active // false' <<<"$input")" = "true" ] && exit 0   # never block twice in a row
sid=$(jq -r '.session_id // "unknown"' <<<"$input")
f="${TMPDIR:-/tmp}/inwardis-summary-gate/$sid"
[ -f "$f" ] || exit 0                                     # nothing written since the last summary
read -r n first <"$f"
after_writes=${INWARDIS_SUMMARY_AFTER_WRITES:-10}
after_seconds=${INWARDIS_SUMMARY_AFTER_SECONDS:-1800}
age=$(( $(date +%s) - first )); due=no
if [ "$n" -ge "$after_writes" ] || [ "$age" -ge "$after_seconds" ]; then due=yes; fi
# Optional: one line per decision, for tuning the thresholds. Nothing is written unless you ask.
[ -n "$INWARDIS_SUMMARY_LOG" ] && echo "$(date -Is) $sid writes=$n age=${age}s asked=$due" >>"$INWARDIS_SUMMARY_LOG"
if [ "$due" = yes ]; then
  printf '{"decision":"block","reason":"You have made %s changes to the Inwardis model since your last summary (the reminder is set to %s). Before stopping, call record_session_note with two or three sentences: what you did, and what is unfinished."}\n' "$n" "$after_writes"
fi
exit 0
