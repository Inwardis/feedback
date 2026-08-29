# Inwardis Roadmap

Inwardis is a model-based knowledge base for your systems, built on one idea: **everything is a
hierarchy** — elements contain sub-elements, so you model a system once and drill down through it
at every level of detail. Diagrams, documentation and exports are projections of that model,
generated rather than maintained by hand.

Two kinds of reader work in the same model: **people**, through the canvas, the explorer and a
VS Code drive — and **AI agents**, through MCP, browsing layer by layer and following relations
instead of swallowing the whole model at once. Both can update it.

This is our public roadmap. It shows the direction of the product, not committed dates.
Priorities shift with your feedback — **[open an issue](https://github.com/inwardis/feedback/issues/new/choose)**
or 👍 an existing one to help us rank what's next.

---

## ✅ Available now

The core product, shipping at launch:

- **Hierarchical modelling** — model vs view separation, drill-down, view anchors, multi-view.
- **18 built-in templates** — Simple Drawing, Database Design, Flowchart, Infrastructure,
  UML Class, API Design, C4 Model, Event-Driven Architecture, Deployment Topology, Mind Map,
  JSON Structure, UML State Machine, Issues, BPMN Process, UML Use Case, UML Activity, Git,
  and an icon-based Deployment template.
- **Author your own templates** — a YAML DSL for domains, shapes, properties, and rules,
  including custom SVG shapes.
- **Dual authoring** — drag-and-drop canvas *and* a human-readable textual language (ITL).
- **Reverse engineering** — generate a model from a live **PostgreSQL, MySQL, SQL Server, or
  Oracle** database.
- **Import** — OpenAPI/Swagger, JSON samples, Sparx EA (XMI), draw.io, Mermaid, CSV, Structurizr.
- **Export** — SVG, PNG, JSON, YAML, Markdown, Mermaid, and ITL round-trip.
- **Versioning** — Git-backed history, diffs, preview, restore, and remote push/merge.
- **Sharing & access** — projects, organizations, teams, public links, and effective-access
  visibility.
- **Accounts** — built-in auth with email MFA, plus optional OIDC single sign-on (Keycloak,
  Azure AD, …) for on-premise.
- **AI-assisted modelling** — a built-in MCP server with **36 tools**: agents read the model
  layer by layer, follow incoming and outgoing relations, search names, types and notes across
  the workspace, create and correct elements, relations and views, lay out, render, import and
  export. Scoped, revocable API keys; every call rate-limited and audited.
- **Model health** — a report that names the gaps a reader would trip over: unsummarised
  branches, unconnected elements, dangling references. It measures, it never blocks a write.
- **Readable outside the product** — a browsable Markdown documentation export, prose stored as
  `.md` files beside the element it describes, and server-rendered SVG with embeddable URLs.
- **VS Code extension** — mount a model as a virtual filesystem (`inwardis://`), browse it as
  folders and files, edit notes, search the model server-side, with live change updates.
- **Operations** — an admin panel, full workspace backup & restore, and built-in observability
  (metrics, structured logs, performance dashboard).
- **In-app help** — the complete user manual, searchable, right inside the app.
- **On-premise** — runs entirely on your infrastructure via Docker; your data never leaves it.

## 🚧 Next — around launch

- Production hardening and general-availability launch.
- Real-time collaboration (live multi-user editing, presence) graduating from preview.

## 🔭 Later — exploring

Direction, not commitments — your feedback moves these up or down:

- **AI generation & assistant** — describe a system and get a first-draft model; an in-app
  assistant for editing and Q&A.
- **Editor & CLI integrations** — the VS Code extension on the Marketplace, and a command-line tool.
- **Guided specification modelling** — domain packs that know what a complete specification
  contains, and an agent that interviews you to fill the gaps before the technical modelling starts.
- **Deeper Sparx EA (XMI) import** — more diagram types and dialect coverage, for teams migrating
  off EA.
- **Embeds & living documentation** — diagrams that stay in sync inside your docs.
- **Template marketplace** — share and discover community templates.
- **Also on the list** — PDF export, issue-tracker integrations, additional UML diagram types
  from XMI, and internationalization.

---

*Something missing, or a rough edge to report?
**[Open an issue](https://github.com/inwardis/feedback/issues/new/choose)** — this repo is where
Inwardis planning and feedback happen in the open. (The product source is developed privately;
this repo is for the roadmap and your reports.)*
