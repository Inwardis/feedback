# Claude Code hooks for Inwardis

Small, optional hooks for people who let [Claude Code](https://claude.com/claude-code) work on an
Inwardis model over MCP. They run on **your machine**, not on the Inwardis server: nothing in the
product depends on them, and nothing installs them for you.

## The summary reminder

When an agent finishes a piece of work it can leave a short summary (`record_session_note`), which
Inwardis shows in the project's activity thread beside a count of what the agent actually changed.
Whether it does so is your team's practice. This hook makes a Claude Code session *unable to walk
away from a pile of unsummarised changes* — and asks **occasionally, never every turn**.

| File | Hook | What it does |
|---|---|---|
| `inwardis-summary-gate.sh` | `Stop` | At the end of a turn, asks your Inwardis server what this key has written in its current session that no summary covers yet. Asks the agent for a summary only when 10 such changes have piled up or the oldest is 30 minutes old. Never after a turn that changed nothing, never twice in a row. |
| `settings.example.json` | — | The wiring, to merge into your Claude Code settings. |

**It asks the server; it does not count.** The answer comes from Inwardis's audit log
(`my_recent_activity {only: "unsummarised"}`), so it covers every change the agent made, however
it made it — through the MCP tools, by running a script that talks to Inwardis itself, or from a
second session on the same key. *(The first published version, 2026-09-21, counted tool names on
your machine with a second hook, `inwardis-count-writes.sh`, and missed all of those. If you
installed it, delete that file and its `PostToolUse` entry.)*

The script is about forty lines of bash. It reads the JSON Claude Code hands a hook, makes one
request to **your own** Inwardis server with `curl`, and writes nothing unless you ask for a log.
The key is passed to `curl` on standard input, never on its command line, and is never logged.
Read it before you install it — that is the point of shipping it as a file.

### Install

Needs `jq` and `curl`, Inwardis 1.0.0-rc.73 or later (the first release to answer the question —
against an older one the hook simply stays silent), and the Inwardis MCP server registered in
Claude Code under the name `inwardis`. **Nothing else to configure:** the hook reads the server's
URL and key from that same registration (`.mcp.json` in the project, or `~/.claude.json`), so it
asks about exactly the key your agent writes with.

```bash
mkdir -p ~/.claude/hooks && cd ~/.claude/hooks
curl -fsSLO https://raw.githubusercontent.com/inwardis/feedback/main/agents/claude-code/inwardis-summary-gate.sh
chmod +x inwardis-summary-gate.sh
```

Then merge the `hooks` block of [`settings.example.json`](settings.example.json) into
`~/.claude/settings.json` — for you alone — or into a repository's `.claude/settings.json`, for
everyone who works in it (use a `$CLAUDE_PROJECT_DIR/...` path there and commit the script with it).
Hooks are read when a session starts: restart Claude Code.

No network? The same script is printed in full in the product's manual and in-app help, under
*Activity, Awareness and Presence → A reminder to summarise*.

### Tune it

What a reminder costs is **one extra model round each time it fires**; asking the server costs one
small local request and no model tokens. Fit the thresholds to how your sessions run:

| Variable | Default | |
|---|---|---|
| `INWARDIS_SUMMARY_AFTER_WRITES` | `10` | changes no summary covers yet |
| `INWARDIS_SUMMARY_AFTER_SECONDS` | `1800` | age of the oldest such change |
| `INWARDIS_SUMMARY_LOG` | *(unset)* | a file path: one line per turn that had unsummarised changes — how many, how old, whether it asked — and one line whenever it had to skip, with the reason. A day of that tells you whether the thresholds fit. |
| `INWARDIS_MCP_URL`, `INWARDIS_API_KEY` | *(from Claude Code's config)* | only if the hook should ask a different server or key than the session uses. Keep a key out of any `settings.json` you commit. |
| `INWARDIS_SUMMARY_TIMEOUT` | `3` | seconds to wait for the server before letting the turn end |

### What to know

- **It fails open.** Server down, no key, an older Inwardis: the turn simply ends. A reminder must
  never be able to wedge a session.
- **One key per agent.** The count is kept per API key, because that is what the record knows. Two
  agents sharing a key share one window: a summary left by one covers the other's changes too.
- **A session that is over owes nothing.** A key quiet for half an hour has ended its session; the
  reminder is for work in progress.
- A session that ends without a final turn is not caught — `SessionEnd` cannot block. The summary
  is a practice; the hook is a nudge.

---

*These files are mirrored from the product repository, where the test suite runs them on every
build (against a stub of the server) and the manual's copy is generated from them. A pull request here would be overwritten by the
next sync — corrections are welcome as issues.*
