# Bring a ticket's comments onto the model item

Inwardis does not talk to your issue tracker. It does not need to: an agent that has **both** MCP
servers — Inwardis and your tracker's own (Jira, GitHub, GitLab and most others publish one) — can
carry the conversation across, and you keep control of when, which tickets, and with whose
credentials. Nothing is stored in Inwardis except the link and the comments themselves.

## What you need

- An item with its **Ticket** filled in. Features, issues and phases (the *Issues* template),
  requirements, constraints and acceptance tests (*Requirements*), risks and controls (*Risk
  register*) have a `ticket` property: paste the ticket's URL in the properties panel — the button
  beside it opens the ticket in a new tab. An agent sets it with
  `update_element {elementId, properties: {ticket: "https://…/browse/ABC-12"}}`.
- An agent (Claude Code, or any MCP client) configured with the Inwardis MCP server **and** your
  tracker's MCP server. The tracker's credentials are the agent's — yours — not the product's.

## The prompt

Give the agent this, as a one-off, on a schedule, or from a hook:

```text
In the Inwardis project "<project name>", find every element whose `ticket` property is set
(search_elements, then read_element for the property).

For each one:
1. Read the ticket it points at with the tracker's tools, including its comments.
2. Read the element's existing comments with list_comments.
3. For every ticket comment that is not already on the element, add it with add_comment, as:

     **<author name>, in <TICKET-KEY>, <date>:**
     <the comment text>
     <link to the comment>

   A comment counts as already there when an existing comment contains its link.
4. Do not edit or delete anything, in either system. Do not copy the element's comments to the ticket.

Finish with record_session_note: how many comments arrived, on which items.
```

## Why it is shaped like this

- **The link is the de-duplication key.** Every tracker gives a comment a permanent URL; an element
  comment that contains it is that comment. No cursor to store, and a second run is harmless.
- **One direction, comments only.** A ticket's comments are read by people who may have no access
  to the model; sending the model's discussion outward is a decision for a person, per comment.
- **The author is named in the text**, and Inwardis records the agent (and whose key it is) as the
  one who brought it — so the trail says both who said it and who carried it.
- **Finding the item from the ticket** works too: `search_elements {query: "ABC-12"}` matches the
  `ticket` property, so an agent that starts from a ticket can land on the element it is about.
