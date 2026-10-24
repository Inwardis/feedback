# Issue labels

A small, meaningful label set — enough to triage, not so many it rots. Create them with the
`gh` script below (run from an authenticated `gh` session, inside the feedback repo).

## Labels

| Label | Color | Purpose |
|-------|-------|---------|
| `needs-triage` | `#ededed` | New, not yet reviewed (applied by the issue templates) |
| `bug` | `#d73a4a` | Something isn't working |
| `enhancement` | `#a2eeef` | New feature or improvement request |
| `question` | `#d876e3` | Needs clarification / a question |
| `roadmap` | `#0e8a16` | Accepted onto the roadmap |
| `in-progress` | `#fbca04` | Being worked on |
| `shipped` | `#5319e7` | Released |
| `duplicate` | `#cfd3d7` | Already tracked elsewhere |
| `wontfix` | `#ffffff` | Out of scope / won't be done |
| `good-first-issue` | `#7057ff` | Approachable, well-scoped |
| **Area labels** | | |
| `area:canvas` | `#c5def5` | Canvas / editing |
| `area:templates` | `#c5def5` | Templates |
| `area:import` | `#c5def5` | Reverse engineering / import |
| `area:export` | `#c5def5` | Export |
| `area:versioning` | `#c5def5` | Versioning / collaboration |
| `area:sharing` | `#c5def5` | Sharing / access |
| `area:admin` | `#c5def5` | Admin / operations |
| `area:ai` | `#c5def5` | AI / MCP / API |

## Create them with `gh`

```bash
# Run inside a clone of the feedback repo (or add `--repo owner/feedback`).
create() { gh label create "$1" --color "$2" --description "$3" --force; }

create needs-triage     ededed "New, not yet reviewed"
create bug              d73a4a "Something isn't working"
create enhancement      a2eeef "New feature or improvement"
create question         d876e3 "Needs clarification"
create roadmap          0e8a16 "Accepted onto the roadmap"
create in-progress      fbca04 "Being worked on"
create shipped          5319e7 "Released"
create duplicate        cfd3d7 "Already tracked elsewhere"
create wontfix          ffffff "Out of scope"
create good-first-issue 7057ff "Approachable, well-scoped"

for a in canvas templates import export versioning sharing admin ai; do
  create "area:$a" c5def5 "Area: $a"
done
```
