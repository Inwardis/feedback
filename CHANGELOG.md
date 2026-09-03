# Changelog

All notable changes to Inwardis, newest first. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versions are the image tags you
install. During the pre-release period every release candidate has its own section.

The section for a version is what the downloads page and the in-product *What's New* page
show, so it is written for the people who install the product, not for its developers.

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
