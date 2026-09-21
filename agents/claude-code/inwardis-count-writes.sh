#!/usr/bin/env bash
# PostToolUse — count Inwardis writes since the last summary. Prints nothing, on purpose.
input=$(cat)
tool=$(jq -r '.tool_name // ""' <<<"$input")
sid=$(jq -r '.session_id // "unknown"' <<<"$input")
dir="${TMPDIR:-/tmp}/inwardis-summary-gate"; mkdir -p "$dir"; f="$dir/$sid"
case "$tool" in
  mcp__inwardis__record_session_note) rm -f "$f" ;;          # summarised — start over
  mcp__inwardis__add_comment|mcp__inwardis__create_version) ;; # talk and checkpoints are not work to summarise
  mcp__inwardis__create_*|mcp__inwardis__update_*|mcp__inwardis__delete_*|mcp__inwardis__apply_*|mcp__inwardis__add_*|mcp__inwardis__remove_*|mcp__inwardis__import_*)
    now=$(date +%s)
    if [ -f "$f" ]; then read -r n first <"$f"; else n=0; first=$now; fi
    echo "$((n + 1)) $first" >"$f" ;;
esac
exit 0
