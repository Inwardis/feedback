# Changelog

All notable changes to Inwardis, newest first. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versions are the image tags you
install.

The newest version is described in full. Every earlier version is listed with a one-line
summary of the areas it changed. This file is what the downloads page, the releases page and
the in-product *What's New* page show, and it is written for the people who install the
product, not for its developers.

## [1.0.22] - 2026-10-28

What changed since 1.0.21: typing beside inline comments is fast again, and Review shows the
comments under what you have selected.

Areas: comments, the MCP server

### Added

- **Review follows your selection.** With an element selected, on the canvas or in the explorer,
  the **Review** button's count and the Review pane cover that element and everything beneath it.
  Several selected elements count together, and with nothing selected Review covers the whole
  project, as before. The pane's first line says what it covers. Opening a comment from the pane
  keeps the pane where it was, and **Show the whole project** widens it until you select something
  else.
- **For agents: comments under an element.** `list_comments` takes `underElementIds` beside
  `projectId` and answers the threads on those elements and everything beneath them, the same list
  the Review pane shows for a selection.

### Fixed

- **Typing in the notes or in the comment box no longer slows down on elements with many inline
  comments.** A commented passage that contains bold or italic text is also no longer marked
  *orphaned* while it is highlighted in the notes.
- **For agents: an inline comment may quote the passage as the Markdown you read.** Bold, italics,
  code and links in the quote are ignored when the passage is found.
- **A project that cannot be loaded now says so** with a message, instead of opening an empty
  diagram.
- **Security update** to a library the OpenAPI import uses.

## [1.0.21] - 2026-10-24

Changes to the MCP server and the canvas.

## [1.0.20] - 2026-10-23

Changes to the MCP server.

## [1.0.19] - 2026-10-23

Changes to the MCP server, the canvas and collaboration.

## [1.0.18] - 2026-10-17

Changes to administration.

## [1.0.17] - 2026-10-15

Changes to the canvas.

## [1.0.16] - 2026-10-15

Changes to the MCP server, templates and the VS Code extension.

## [1.0.15] - 2026-10-13

Changes to the MCP server, the canvas and the VS Code extension.

## [1.0.14] - 2026-10-07

Changes to the MCP server. Security updates.

## [1.0.13] - 2026-10-07

Changes to templates, the canvas and the MCP server. Security updates.

## [1.0.12] - 2026-10-06

Changes to the canvas, templates and the MCP server. Security updates.

## [1.0.11] - 2026-10-04

Changes to the canvas, the MCP server and templates.

## [1.0.10] - 2026-10-03

Changes to the MCP server, the canvas, import/export and the VS Code extension. Security updates.

## [1.0.9] - 2026-09-30

Changes to the MCP server, import/export and administration. Security updates.

## [1.0.6] - 2026-09-28

Changes to versioning, the MCP server, the VS Code extension and administration.

## [1.0.5] - 2026-09-24

Changes to the canvas.

## [1.0.4] - 2026-09-24

Changes to the canvas.

## [1.0.3] - 2026-09-24

Changes to the canvas and the VS Code extension.

## [1.0.1] - 2026-09-23

Changes to versioning, templates, the MCP server and the canvas.

## [1.0.0-rc.80] - 2026-09-23

Changes to administration.

## [1.0.0] - 2026-09-23

The first production release.

## [1.0.0-rc.79] - 2026-09-23

Changes to versioning.

## [1.0.0-rc.78] - 2026-09-23

Changes to import/export and search.

## [1.0.0-rc.77] - 2026-09-22

Changes to templates and import/export.

## [1.0.0-rc.76] - 2026-09-22

Changes to the MCP server, versioning and import/export.

## [1.0.0-rc.75] - 2026-09-21

Changes to the canvas, administration and help.

## [1.0.0-rc.74] - 2026-09-21

Changes to the MCP server, versioning, collaboration and administration.

## [1.0.0-rc.73] - 2026-09-21

Changes to the MCP server, collaboration and the canvas.

## [1.0.0-rc.72] - 2026-09-20

Changes to the VS Code extension and help.

## [1.0.0-rc.71] - 2026-09-20

Changes to the VS Code extension, administration and help.

## [1.0.0-rc.70] - 2026-09-20

Changes to the MCP server.

## [1.0.0-rc.69] - 2026-09-20

Changes to the canvas, the MCP server and versioning.

## [1.0.0-rc.68] - 2026-09-19

Changes to the canvas and the MCP server.

## [1.0.0-rc.67] - 2026-09-19

Changes to the MCP server and templates.

## [1.0.0-rc.66] - 2026-09-19

Changes to the MCP server, collaboration, the canvas and templates.

## [1.0.0-rc.65] - 2026-09-15

Changes to the MCP server and the canvas.

## [1.0.0-rc.64] - 2026-09-15

Changes to the canvas, the MCP server and collaboration.

## [1.0.0-rc.63] - 2026-09-14

Changes to the canvas, collaboration and administration.

## [1.0.0-rc.62] - 2026-09-14

Changes to the MCP server, templates, import/export and collaboration.

## [1.0.0-rc.61] - 2026-09-14

Changes to collaboration and the canvas.

## [1.0.0-rc.60] - 2026-09-14

Changes to collaboration.

## [1.0.0-rc.59] - 2026-09-14

Changes to the MCP server.

## [1.0.0-rc.58] - 2026-09-13

Changes to the MCP server.

## [1.0.0-rc.57] - 2026-09-13

Changes to the MCP server.

## [1.0.0-rc.56] - 2026-09-13

Changes to the canvas and templates.

## [1.0.0-rc.55] - 2026-09-13

Changes to the MCP server, the canvas and import/export.

## [1.0.0-rc.54] - 2026-09-12

Changes to versioning.

## [1.0.0-rc.53] - 2026-09-12

Changes to the MCP server.

## [1.0.0-rc.52] - 2026-09-12

Changes to the MCP server and the VS Code extension.

## [1.0.0-rc.51] - 2026-09-12

Changes to the VS Code extension and the MCP server.

## [1.0.0-rc.50] - 2026-09-11

Changes to the canvas and versioning.

## [1.0.0-rc.49] - 2026-09-11

Changes to the canvas.

## [1.0.0-rc.48] - 2026-09-11

Changes to the canvas and templates.

## [1.0.0-rc.47] - 2026-09-11

Changes to the canvas.

## [1.0.0-rc.46] - 2026-09-11

Changes to the canvas and import/export.

## [1.0.0-rc.45] - 2026-09-10

Changes to administration.

## [1.0.0-rc.44] - 2026-09-10

Changes to versioning and administration.

## [1.0.0-rc.43] - 2026-09-10

Maintenance and fixes.

## [1.0.0-rc.42] - 2026-09-10

Changes to the canvas.

## [1.0.0-rc.41] - 2026-09-10

Changes to collaboration.

## [1.0.0-rc.40] - 2026-09-10

Changes to the canvas.

## [1.0.0-rc.39] - 2026-09-10

Changes to the MCP server and the canvas.

## [1.0.0-rc.38] - 2026-09-10

Changes to the canvas.

## [1.0.0-rc.37] - 2026-09-09

Changes to the canvas and import/export.

## [1.0.0-rc.36] - 2026-09-09

Changes to versioning and administration.

## [1.0.0-rc.35] - 2026-09-09

Changes to the MCP server and collaboration.

## [1.0.0-rc.34] - 2026-09-09

Changes to the canvas and the MCP server.

## [1.0.0-rc.33] - 2026-09-09

Changes to collaboration, the MCP server and the canvas.

## [1.0.0-rc.32] - 2026-09-09

Changes to administration and versioning.

## [1.0.0-rc.31] - 2026-09-08

Changes to administration.

## [1.0.0-rc.30] - 2026-09-08

Changes to administration and the MCP server.

## [1.0.0-rc.29] - 2026-09-07

Changes to the canvas and templates.

## [1.0.0-rc.28] - 2026-09-07

Changes to the MCP server.

## [1.0.0-rc.27] - 2026-09-07

Changes to the MCP server, the VS Code extension and administration.

## [1.0.0-rc.26] - 2026-09-07

Changes to the VS Code extension.

## [1.0.0-rc.25] - 2026-09-07

Changes to the MCP server and import/export.

## [1.0.0-rc.24] - 2026-09-07

Changes to the MCP server.

## [1.0.0-rc.23] - 2026-09-07

Changes to the canvas.

## [1.0.0-rc.22] - 2026-09-07

Changes to the canvas.

## [1.0.0-rc.21] - 2026-09-07

Changes to the canvas, the MCP server, templates and versioning.

## [1.0.0-rc.20] - 2026-09-04

Changes to templates, versioning and administration.

## [1.0.0-rc.17] - 2026-09-04

Changes to import/export.

## [1.0.0-rc.16] - 2026-09-04

Changes to import/export.

## [1.0.0-rc.15] - 2026-09-04

Changes to versioning and the MCP server.

## [1.0.0-rc.13] - 2026-09-03

Changes to the MCP server and the VS Code extension.

## [1.0.0-rc.12] - 2026-09-03

Changes to the canvas.

## [1.0.0-rc.11] - 2026-09-03

Changes to the canvas, import/export and administration.

## [1.0.0-rc.10] - 2026-09-03

Changes to administration, templates and help.

## [1.0.0-rc.9] - 2026-09-03

Changes to versioning and help.

## [1.0.0-rc.8] - 2026-09-03

Changes to the MCP server and templates.

## [1.0.0-rc.7] - 2026-09-02

Changes to versioning, import/export and administration.

## [1.0.0-rc.6] - 2026-09-02

Changes to administration and templates.

## [1.0.0-rc.5] - 2026-09-02

Changes to administration.

## [1.0.0-rc.1] … [1.0.0-rc.4] - 2026-09-02 — withdrawn

First builds published through the download channel. All four carry a seeded development
administrator and must not be installed; rc.3 introduced first-registrant-becomes-admin,
rc.4 the alpha front door. Superseded by rc.5.
