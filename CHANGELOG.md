# Changelog

All notable changes to Inwardis, newest first. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versions are the image tags you
install. During the pre-release period every release candidate has its own section.

The section for a version is what the downloads page and the in-product *What's New* page
show, so it is written for the people who install the product, not for its developers.

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
