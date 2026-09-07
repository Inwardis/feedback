# Changelog

All notable changes to Inwardis, newest first. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versions are the image tags you
install. During the pre-release period every release candidate has its own section.

The section for a version is what the downloads page and the in-product *What's New* page
show, so it is written for the people who install the product, not for its developers.

## [1.0.0-rc.27] - 2026-09-07

### Added
- **Attachments in VS Code.** An element with files shows them under `_attachments/` in the
  mounted model; open one and it arrives through VS Code's own viewers. Drop or paste a file
  into `_attachments/` (or onto the element folder) to attach it, delete one to remove it; a
  drop onto an existing name is refused, delete first. The bundled extension is 0.14.0 and
  needs this server version for the file listing.
- **Attachment files over the API with an API key.** The attachment routes (list, download,
  upload, delete) now accept an `ink_…` key — read scope to list and download, write scope to
  upload and delete — so an agent moves a file with one `curl` instead of pushing it through the
  model as base64. `list_attachments`, `read_project_tree` and `read_element` return each file's
  download path; the Integrations help page shows the two commands.

### Changed
- `add_attachment` / `get_attachment` describe the API route first and the in-call base64 form
  as the fallback for content the agent holds in memory. The over-limit answer from
  `get_attachment` now names a route the key can actually use.

## [1.0.0-rc.26] - 2026-09-07

### Changed
- **VS Code: the project list is a tree.** *Inwardis: Open Project as Workspace Folder* now
  lists projects the way the app's explorer does — root projects by name, subprojects
  indented beneath their parent, the parent path shown beside each subproject so typing a
  parent's name filters to its subtree. The bundled extension is 0.12.0; install it again from
  the downloads page to get it.

## [1.0.0-rc.25] - 2026-09-07

### Changed
- **Help: "Importing Models."** The page that used to be titled *Reverse Engineering & Import*
  is now *Importing Models* — it has covered file, JSON, Sparx EA and repository imports only
  since live database reverse engineering went dark. Same links, same content.
- The Integrations help page describes the configurable agent rate limits, the wait reported in
  a refused call, re-runnable creates (`ifExists`), relations without a view and the attachment
  tools; Properties & Notes mentions attachments over MCP; Licensing says the price is tax
  included; The Canvas says a drop onto another element keeps the element on the view.

## [1.0.0-rc.24] - 2026-09-07

### Added
- **Attachments over MCP.** An agent can now list an element's files, fetch one, add one and
  remove one — `list_attachments`, `get_attachment`, `add_attachment`, `delete_attachment`.
  Content travels base64 inside the call, capped at 8 MB (`MCP_ATTACHMENT_MAX_BYTES`); a larger
  file is refused with the REST upload endpoint named. What is added over MCP appears in the
  properties panel like any other attachment.

## [1.0.0-rc.23] - 2026-09-07

### Added
- **Show Connections.** Right-click an element → *Show Connections* (or Ctrl+Shift+L): a new
  tab opens around that element with everything a relation connects it to arranged around it —
  sources on the left, targets on the right, both-ways above, lines labelled. Double-click a
  neighbour to re-centre on it; *Expand Connections Here* adds its ring. The tab is temporary:
  never saved, never in the history, gone when you close it — or right-click it → *Keep as view*.

## [1.0.0-rc.22] - 2026-09-07

### Added
- **Show in Explorer.** Right-click a box on the canvas → *Show in Explorer*, or press
  Ctrl+Shift+E with one element selected: the explorer panel opens if it was collapsed, the tree
  unfolds to that element, scrolls it into view and selects it. The reverse of the explorer's
  *Locate on Canvas*, for the moment a box on a big diagram is easy to see and hard to place in
  the tree.

## [1.0.0-rc.21] - 2026-09-07

### Added
- **Move an element without dragging.** Right-click it in the explorer → *Move to…*, or use
  *Parent → Change…* in the properties panel, to put it under any other element or promote it to
  the top level. The picker shows every candidate and greys out the ones that cannot take it, with
  the reason. A move keeps the element on every view it is placed on.
- **Re-runnable imports for agents.** `create_element` and `create_relation` accept
  `ifExists: skip | update`, keyed on what you can name (parent, type and name; source, target and
  type), so a script that builds a model can be run again without creating duplicates. Two rows
  that already share the key are refused rather than guessed between.
- **Relations no longer need a view.** `create_relation` without a `viewId` writes the relation
  into the model; it is drawn on every view where both ends are placed, and the response says which.
- **Agent rate limits are configurable.** `MCP_RATE_LIMIT_ENABLED` and `MCP_RATE_LIMIT_READ`,
  `_WRITE`, `_BULK`, `_OVERALL` set the per-key limits; the defaults are six times higher than
  before, sized for one person and one agent on one machine. A refused call now says in its body
  how many seconds to wait.

### Changed
- **Dropping an element into another keeps it on the view**, drawn inside its new parent, instead
  of removing it from the diagram.
- **A Decision can be marked as enforced in a component** in the Issues template, alongside
  Invariants and Rules.
- Searching the model counts as a read for rate limiting, and creating a version as a write,
  so neither competes with batch writes for the smaller bulk budget.
- The project brief names the highest-numbered phase as the latest when several closed on the
  same day.

## [1.0.0-rc.20] - 2026-09-04

> rc.18 and rc.19 were tagged the same afternoon and never published: their image builds refused
> themselves at a new release check that needed a tool the build machine lacks. rc.20 is both of
> them, with the check fixed.

### Added
- **Six general-purpose templates** — Org Chart, Capability Map, Concept Map, Requirements,
  Risk Register and Business Model Canvas — the first built-ins with nothing software-specific in
  them. Each is a hierarchy you can drill into plus the typed relations of its domain, and each
  can reference elements in other models. The Templates help page lists when to reach for which.


- **A test build beside every release.** Each version now also ships as `<version>-test`, a
  build that trusts the *test* licensing key. The test environment's downloads page hands out
  that build, so a trial or purchase made on the test site works in the copy you were told to
  install. The licence page and `/actuator/info` say which build you are running; a test build
  shows a clear banner.

### Changed
- **A licence key signed for another build is refused with a message that says so** — which key
  this build trusts and which key signed yours — instead of a signature error from the JWT library.

## [1.0.0-rc.17] - 2026-09-04

### Changed
- **Import from a published repository is offered under *Create Subproject* too.** The copy lands
  beneath that project as a subproject; the wizard says where it will go.

## [1.0.0-rc.16] - 2026-09-04

### Added
- **Import from a published repository.** A project another Inwardis instance pushed to git can
  be imported from its URL — *Create Project → Start from → A published repository*, or
  `import_git_repository` over MCP, or `POST /api/v1/import/git` — as a **new project with new
  ids**: a copy, not a link. Nothing is configured to push back. A publication with subprojects
  becomes a project with subprojects; references that point outside the imported publication are
  dropped and counted, and a template this instance lacks is reported with its elements skipped
  rather than imported as something else. Optional token (used once, never stored), branch and
  subfolder.

### Changed
- The release image is now built on a Gradle base image, so building it no longer depends on
  downloading Gradle during the build.

## [1.0.0-rc.15] - 2026-09-04

> rc.14 was tagged the same morning and never published — its image build failed on the build
> infrastructure (a download timeout), not on the product. rc.15 is that release with the build
> made tolerant of a slow mirror.

### Fixed
- **Remote git: a merge now updates the model itself.** *Fetch & Merge* in Git Settings, the merge
  a push runs first, and a resolved remote conflict all apply the merged state to the project and
  move its version. Previously only the repository moved: the canvas looked unchanged after
  "Merged remote changes", and the next save silently reverted the incoming edit — locally and,
  on the next push, on the remote. If the database update fails, the merge commit is rolled back
  rather than left standing without its state.

- **The first push to a new repository works from the Push button**, whether the provider left the
  repository empty or created it with a README. Before, an empty repository failed with
  "Pre-fetch failed" and a README-initialized one with "No common ancestor found"; the README case
  is absorbed into history as documented, and a repository that already holds another model is
  still refused. Fetch & Merge against unrelated history now says so instead of reporting an error.

### Changed
- **The project knowledge kit explains itself.** The create-project dialog says the kit is
  optional and not a model — three boards for the work *on* a model — and when it is worth adding,
  with a help link to a new manual section, *The kit: what it is, and when it is worth having*.
  *Core Concepts* gains *Knowledge about the model*, and `create_knowledge_kit` says the same to
  agents.

## [1.0.0-rc.13] - 2026-09-03

### Added
- `learn` gains the topic **project-knowledge**: how an agent keeps track of its own work on a
  model inside the model — findings, decisions, rules, phases and questions as elements, when
  to write each, how several agents share it, project notices as binding rules, and how to
  start a session. Also a help page: *Keeping a Project's Knowledge*.

- **VS Code extension 0.11.0** (bundled): the code-reference scan and CodeLens now show whether
  each mark is *stale*, *fresh* or *unverified* against the element's verified-on date, using the
  file's last commit date from git, and offer **Mark as verified** on a click.

- **`project_brief`** (MCP) and `GET /api/v1/projects/{id}/brief`: the state of the work on a
  project, computed from its knowledge elements — open findings, ideas, questions and proposed
  decisions, phases by status with the latest, verification counts — as JSON and as Markdown.
  Read it first in a session.

- **Project knowledge kit**: *Create Project → Start from → Project knowledge kit* (also
  `create_knowledge_kit` over MCP and `POST /api/v1/projects/knowledge-kit`) creates the three
  projects the practice needs — Findings, Decisions & rules, Phases — each with a Board view and
  its writing rules as a notice that every agent sees when it writes there.

## [1.0.0-rc.12] - 2026-09-03

### Added
- The **Issues** template (1.6) gains a project-knowledge vocabulary: **Decision, Invariant,
  Rule, Phase, Question** with status, provenance and a verified-on date, and the relations
  *Violates*, *Enforced In*, *Closed By* (cross-project) and *Supersedes*. Issues gain provenance
  and verified-on too. Existing Issues projects pick the new types up automatically unless the template was
  customised.

- **Code references know when they went stale.** `resolve_elements` accepts, per mark, the date
  the marked code last changed and answers *stale*, *fresh* or *unverified* against the
  element's verified-on date. The C4 template (1.2) gains verified-on on systems, containers
  and components.

## [1.0.0-rc.11] - 2026-09-03

### Fixed
- Adding a child element from the explorer while the **parent's** level was on screen also
  drew the child beside its parent, as if it were a sibling — and saved it that way, so exports
  showed it too. A new element is now placed only in the view that draws its parent's children;
  drill into the parent to see it. Placing an element elsewhere on purpose is still done with
  *Show on canvas*.
- The window title and the top-left product name read "Inwardis Spike"; the leftover word is
  gone.
- **Downloads that stream** — the audit log CSV, the error log export, the workspace backup and
  the docs export — failed after the first bytes with "Failed to export". The authenticated
  session was lost on the second half of the response; it is kept now.
- The compose file and the install guide now list the optional settings (email, MFA, feature
  switches, limits, metrics, JVM) with a pointer to the full reference; the guide no longer
  claims email is required to log in — email MFA is off by default.
- **System health no longer reports DOWN because email is not configured.** An install without
  `SMTP_HOST` shows the mail component as "not configured" and stays UP; the every-five-minutes
  "System health is DOWN — check … database" audit rows stop. When something is really down,
  the alert names the component and its error, is written once when it starts and once when it
  clears, instead of on every check.

## [1.0.0-rc.10] - 2026-09-03

### Fixed
- **What's new** in the Help panel opened "Unknown help page" — the release notes were not
  packaged into the rc.9 image. They are now, and the build refuses to produce an image
  without them.
- **"Failed to create project"** on a fresh install said nothing about why. Error messages
  from the server now reach you: with no license installed, the message says so and points
  an administrator at Admin → License. The same applies to sharing and template-editing
  errors.
- The read-only refusal itself no longer claims a license "has expired" on an install that
  never had one.
- The **"No active license — read-only mode" banner** now appears after logging in, not only
  after a page reload. On a fresh install it is the first thing an administrator sees.

## [1.0.0-rc.9] - 2026-09-03

### Added
- **What's new** in the Help panel: the footer shows the installed version and opens the
  release notes for every version, this page included.
- The downloads page shows what changed in each version, the newest expanded.

## [1.0.0-rc.8] - 2026-09-03

### Fixed
- **Manage Templates → Apply did nothing** when no project was open. The dialog now says
  *"Open a project first — templates are chosen per project"* and keeps Apply disabled; the
  toolbox gear is disabled until a project is open. A project you can only view gets the same
  treatment.

### Changed
- Live-database reverse engineering is not offered in the initial release. The help pages,
  the MCP integrations page and the roadmap no longer describe it; import a `.sql` dump
  instead.

## [1.0.0-rc.7] - 2026-09-02

### Changed
- **Admin → Feature Flags** lists only the switches that do something on this build
  (collaboration, versioning, MCP). Hidden features are no longer offered as toggles.
- `INWARDIS_VERSION` is **required**: `docker compose up` refuses to start without it instead
  of silently running an older image. Both environment tables in the help document it.
- Help: the developer guide no longer describes writing a database connector; the import page
  starts from a SQL file.

## [1.0.0-rc.6] - 2026-09-02

### Fixed
- **Manage Templates** dialog scrolls; with 18 templates the Apply button had been pushed
  off-screen.
- **Installing a license from the emailed link**: pasting what the browser showed produced
  *"Invalid license key"*. The link now serves a paste-ready key, and the product accepts the
  old envelope form too.
- **Admin → Access**: projects are listed as an indented tree in hierarchy order instead of a
  flat list.

## [1.0.0-rc.5] - 2026-09-02

### Fixed
- **Fresh installs no longer contain a pre-seeded administrator account.** Earlier release
  candidates shipped a development user with a documented password into every install.
  **Do not run rc.1–rc.4.**
- Registering on a fresh install joins the workspace, so the first person to register is
  the administrator and can install the license.

## [1.0.0-rc.1] … [1.0.0-rc.4] - 2026-09-02 — withdrawn

First builds published through the download channel. All four carry a seeded development
administrator and must not be installed; rc.3 introduced first-registrant-becomes-admin,
rc.4 the alpha front door. Superseded by rc.5.
