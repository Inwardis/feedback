#!/usr/bin/env bash
# Stop — ask the Inwardis server what this key has written and not yet summarised,
# and ask for a summary only when that has piled up. Fails open: no answer, no block.
input=$(cat)
[ "$(jq -r '.stop_hook_active // false' <<<"$input")" = "true" ] && exit 0   # never block twice in a row
log() { [ -n "$INWARDIS_SUMMARY_LOG" ] && echo "$(date -Is) $*" >>"$INWARDIS_SUMMARY_LOG"; return 0; }

# Which server, which key: the ones Claude Code itself uses for the `inwardis` MCP server — so the
# question is asked about exactly the key the agent writes with. Environment variables win.
url=$INWARDIS_MCP_URL; bearer=${INWARDIS_API_KEY:+Bearer $INWARDIS_API_KEY}
if [ -z "$url" ] || [ -z "$bearer" ]; then
  dir=${CLAUDE_PROJECT_DIR:-$(jq -r '.cwd // ""' <<<"$input")}
  for cfg in "$dir/.mcp.json" "${CLAUDE_CONFIG:-$HOME/.claude.json}"; do
    [ -f "$cfg" ] || continue
    entry=$(jq -c --arg d "$dir" '(.projects[$d].mcpServers.inwardis // .mcpServers.inwardis) // empty' "$cfg" 2>/dev/null)
    [ -n "$entry" ] || continue
    [ -n "$url" ] || url=$(jq -r '.url // ""' <<<"$entry")
    [ -n "$bearer" ] || bearer=$(jq -r '.headers.Authorization // ""' <<<"$entry")
    break
  done
fi
[ -n "$url" ] && [ -n "$bearer" ] || { log "skipped: no inwardis MCP server found (set INWARDIS_MCP_URL and INWARDIS_API_KEY)"; exit 0; }

# The key goes to curl on stdin, never on its command line, where `ps` would show it.
answer=$(printf 'header = "Authorization: %s"\n' "$bearer" | curl -fsS -K - --max-time "${INWARDIS_SUMMARY_TIMEOUT:-3}" \
  -H 'Content-Type: application/json' "$url" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"my_recent_activity","arguments":{"only":"unsummarised"}}}' 2>/dev/null) \
  || { log "skipped: the server did not answer"; exit 0; }
owed=$(jq -r '.result.content[0].text // empty' <<<"$answer" 2>/dev/null | jq -c '.unsummarised // empty' 2>/dev/null)
[ -n "$owed" ] || { log "skipped: the server answered something else (an older Inwardis?)"; exit 0; }

n=$(jq -r '.writes // 0' <<<"$owed"); age=$(jq -r '.oldestAgeSeconds // 0' <<<"$owed")
after_writes=${INWARDIS_SUMMARY_AFTER_WRITES:-10}
after_seconds=${INWARDIS_SUMMARY_AFTER_SECONDS:-1800}
due=no
if [ "$n" -gt 0 ] && { [ "$n" -ge "$after_writes" ] || [ "$age" -ge "$after_seconds" ]; }; then due=yes; fi
[ "$n" -gt 0 ] && log "writes=$n age=${age}s asked=$due"
if [ "$due" = yes ]; then
  where=$(jq -r '[.projects[] | "\(.name) (\(.writes))"] | join(", ")' <<<"$owed")
  jq -cn --arg n "$n" --arg w "$where" \
    '{decision:"block", reason:("This session has made \($n) change\(if $n == "1" then "" else "s" end) to the Inwardis model that no summary covers yet — \($w). Before stopping, call record_session_note with two or three sentences: what you did, and what is unfinished.")}'
fi
exit 0
