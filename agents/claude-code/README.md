# Claude Code hooks for Inwardis

Small, optional hooks for people who let [Claude Code](https://claude.com/claude-code) work on an
Inwardis model over MCP. They run on **your machine**, not on the Inwardis server: nothing in the
product depends on them, and nothing installs them for you.

## The summary reminder

When an agent finishes a piece of work it can leave a short summary (`record_session_note`), which
Inwardis shows in the project's activity thread beside a count of what the agent actually changed.
Whether it does so is your team's practice. These two hooks make a Claude Code session *unable to
walk away from a pile of unsummarised changes* — and ask **occasionally, never every turn**:

| File | Hook | What it does |
|---|---|---|
| `inwardis-count-writes.sh` | `PostToolUse` | Counts the session's changes to a model in a temp file; starts over when a summary is posted. Prints nothing, so it costs nothing per tool call. |
| `inwardis-summary-gate.sh` | `Stop` | Asks for a summary only when 10 changes have piled up or the oldest is 30 minutes old. Never after a turn that only read, never twice in a row. |
| `settings.example.json` | — | The wiring, to merge into your Claude Code settings. |

Each script is about fifteen lines of bash. They read the JSON Claude Code hands a hook, keep one
small file per session under `$TMPDIR`, and call nothing but `jq` and `date`. Read them before you
install them — that is the point of shipping them as files.

### Install

Needs `jq`, and the Inwardis MCP server registered in Claude Code under the name `inwardis` (if you
named it differently, change `mcp__inwardis__` in the matcher and in the first script).

```bash
mkdir -p ~/.claude/hooks && cd ~/.claude/hooks
curl -fsSLO https://raw.githubusercontent.com/inwardis/feedback/main/agents/claude-code/inwardis-count-writes.sh
curl -fsSLO https://raw.githubusercontent.com/inwardis/feedback/main/agents/claude-code/inwardis-summary-gate.sh
chmod +x inwardis-count-writes.sh inwardis-summary-gate.sh
```

Then merge the `hooks` block of [`settings.example.json`](settings.example.json) into
`~/.claude/settings.json` — for you alone — or into a repository's `.claude/settings.json`, for
everyone who works in it (use `$CLAUDE_PROJECT_DIR/...` paths there and commit the scripts with it).
Hooks are read when a session starts: restart Claude Code.

No network? The same scripts are printed in full in the product's manual and in-app help, under
*Activity, Awareness and Presence → A reminder to summarise*.

### Tune it

What a reminder costs is **one extra model round each time it fires**, so fit it to how your
sessions run:

| Variable | Default | |
|---|---|---|
| `INWARDIS_SUMMARY_AFTER_WRITES` | `10` | changes since the last summary |
| `INWARDIS_SUMMARY_AFTER_SECONDS` | `1800` | age of the oldest unsummarised change |
| `INWARDIS_SUMMARY_LOG` | *(unset)* | a file path: one line per turn that had unsummarised changes — how many, how old, whether it asked. A day of that tells you whether the thresholds fit. |

### What it cannot do

- It sees **tool names, not effects**: changes an agent makes by running a script that talks to
  Inwardis itself are not counted.
- A session that ends without a final turn is not caught — `SessionEnd` cannot block. The summary is
  a practice; the hook is a nudge.

---

*These files are mirrored from the product repository, where the test suite runs them on every
build and the manual's copy is generated from them. A pull request here would be overwritten by the
next sync — corrections are welcome as issues.*
