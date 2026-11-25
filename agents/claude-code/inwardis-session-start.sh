#!/usr/bin/env bash
# SessionStart — tell the agent, in a few lines, what moved in this repository's Inwardis model since
# the last session here, that the model is where to start, and which agent id to send on its calls.
# Fails open: no answer, no output.
input=$(cat)
log() { [ -n "$INWARDIS_SESSION_LOG" ] && echo "$(date -Is) $*" >>"$INWARDIS_SESSION_LOG"; return 0; }
dir=${CLAUDE_PROJECT_DIR:-$(jq -r '.cwd // ""' <<<"$input")}

# Which server, which key: the ones Claude Code itself uses for the `inwardis` MCP server.
url=$INWARDIS_MCP_URL; bearer=${INWARDIS_API_KEY:+Bearer $INWARDIS_API_KEY}
if [ -z "$url" ] || [ -z "$bearer" ]; then
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

# Which agent this session is (Inwardis 1.0.24+): cc- and the first eight characters of Claude Code's
# session id. The summary hook derives the same id, so it asks about this session's writes only —
# several agents can then share one key. INWARDIS_AGENT_CONTEXT=0 leaves it out.
sid=$(jq -r '.session_id // ""' <<<"$input" | tr -cd 'A-Za-z0-9' | cut -c1-8)
agent=""; [ "${INWARDIS_AGENT_CONTEXT:-1}" != "0" ] && [ -n "$sid" ] && agent="cc-$sid"
agent_text=""
[ -n "$agent" ] && agent_text="On every Inwardis tool call, add \"agent\": {\"id\": \"$agent\", \"role\": \"master\"} to the arguments. A subagent you start that uses the Inwardis tools gets its own id: tell it to send {\"id\": \"<its id>\", \"role\": \"subagent\", \"parent\": \"$agent\"} on every call."
say() { jq -cn --arg t "$1" '{hookSpecificOutput:{hookEventName:"SessionStart", additionalContext:$t}}'; exit 0; }

# Which project: INWARDIS_PROJECT_ID, else the marker the generated agent instructions carry
# (`<!-- inwardis-project: <id> -->`, copied from Inwardis into this repository's instructions file).
project=$INWARDIS_PROJECT_ID
if [ -z "$project" ]; then
  for f in "$dir/CLAUDE.md" "$dir/AGENTS.md" "$dir/.claude/CLAUDE.md" "$dir/CLAUDE.local.md"; do
    [ -f "$f" ] || continue
    project=$(grep -oE 'inwardis-project: *[0-9a-fA-F-]{36}' "$f" | head -1 | grep -oE '[0-9a-fA-F-]{36}$')
    [ -n "$project" ] && break
  done
fi
if [ -z "$project" ]; then
  log "no inwardis-project marker in $dir (or set INWARDIS_PROJECT_ID) agent=${agent:-none}"
  [ -n "$agent_text" ] && say "$agent_text"
  exit 0
fi

# Since when: the last time this hook heard from the server for this project. The first run reads the trail.
state=${INWARDIS_SESSION_STATE:-${XDG_STATE_HOME:-$HOME/.local/state}/inwardis}
stamp="$state/session-start-$project"
since=$(cat "$stamp" 2>/dev/null)
now=$(date -u +%Y-%m-%dT%H:%M:%SZ)
args=$(jq -cn --arg p "$project" --arg s "$since" --arg a "$agent" \
  '{projectId:$p, includeChildren:true, groupBy:"hour", limit:20} + (if $s == "" then {} else {since:$s} end)
   + (if $a == "" then {} else {agent:{id:$a, role:"master"}} end)')
body=$(jq -cn --argjson a "$args" '{jsonrpc:"2.0", id:1, method:"tools/call", params:{name:"get_changes", arguments:$a}}')

# The key goes to curl on stdin, never on its command line, where `ps` would show it.
answer=$(printf 'header = "Authorization: %s"\n' "$bearer" | curl -fsS -K - --max-time "${INWARDIS_SESSION_TIMEOUT:-3}" \
  -H 'Content-Type: application/json' "$url" -d "$body" 2>/dev/null) \
  || { log "skipped: the server did not answer"; exit 0; }
items=$(jq -r '.result.content[0].text // empty' <<<"$answer" 2>/dev/null | jq -c '.items // empty' 2>/dev/null)
[ -n "$items" ] || { log "skipped: the server answered something else"; exit 0; }   # an older server refuses `agent`: say nothing
mkdir -p "$state" && echo "$now" >"$stamp"

n=$(jq 'length' <<<"$items")
log "project=$project since=${since:-start} items=$n agent=${agent:-none}"
if [ "$n" -eq 0 ]; then   # nothing moved: only the agent line — this lands in every session's context
  [ -n "$agent_text" ] && say "$agent_text"
  exit 0
fi
shown=${INWARDIS_SESSION_LINES:-5}
lines=$(jq -r --argjson k "$shown" '.[:$k][] | "- " + (.group.sentence // .event.sentence // "a change")' <<<"$items")
more=$(( n > shown ? n - shown : 0 ))
when=${since:+since $since}
text="Inwardis model (project $project) — what moved ${when:-recently}:
$lines"
[ "$more" -gt 0 ] && text="$text
- and $more more"
text="$text
Read the model before you change anything: get_changes {projectId: \"$project\"} for the detail, read_project_tree for the overview."
[ -n "$agent_text" ] && text="$text
$agent_text"
say "$text"
