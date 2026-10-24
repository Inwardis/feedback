# Working Model-First

A model is worth keeping only while it is true. This chapter is the method that keeps one true
when people and AI agents work on it together — the way this product is built, described so you
can take it, adapt it, or ignore the parts that do not fit.

Nothing here is enforced by the product. It is a practice, and practices survive by being
written down.

## Why a model, and not documents

The problem is not that teams fail to write things down. It is that what they write cannot be
asked questions. A fact in a document can only be re-read; a fact in a model can be queried,
counted, related to other facts, and re-verified on a date. That difference decides everything
else in this chapter.

An agent reading a repository builds an understanding, uses it, and throws it away. The next
session starts from nothing, or worse, from a summary of a summary. A model is where that
understanding survives between sessions and between people: the structure, the decisions, the
reasons, and the open questions — one place both a person and an agent can read and write.

One thing follows that no folder of text files gives you: **you can point at the exact thing.**
Every element has an address. Copy a link to one and ask the agent *what did you mean here?*, or
tell it to make that one clearer — it opens what you are looking at, not "the third paragraph of
that file". And because the design is in the model before it is code, that question can be asked
while it is still cheap to answer.

**Code stays linked to the model.** A comment mark ties a class to the element that describes
it, so each can be opened from the other and checked against it — and when the code has moved on
since its description was last verified, that shows. An agent will often write code *from* what
the model says; that is the point of a shared context.

## The practice

Six habits, in the order they matter. The first three are about what you keep; the last three
are about how work gets done.

**Model the thing, not the document about the thing.** One element per real thing, at the level
someone would ask about it. Prose belongs on the element it describes, where the next reader —
or the next agent — will look for it.

**File a finding the moment you hit it.** A defect, a surprise, an idea: one row, one paragraph,
where it came from, the date. Not at the end of the session, by which time you have worked
around it and forgotten what it looked like. A board of findings is the honest record of what a
project actually cost.

**Record a decision when you choose.** If you weighed two ways and took one, write both and the
reason. A decision nobody can find is a decision that gets re-made differently, usually by
someone who was not there the first time.

**Plan before building, and keep the plan.** Design the feature in the model before it is code —
the parts, what they touch, what they must not break. What the work is for, what it will change,
how it will be checked — written before anything changes. A plan written afterwards is a description.
Written first, it is what you check the result against, and it is where a reader later finds
what you decided *not* to do.

**A guard is worth what it fails on.** After writing a test, break the thing it guards and watch
it go red. A test that passes against the defect it was written for is not a guard, and reading
it will not tell you which kind you have. This is the cheapest habit here and the one that has
caught the most: in this product's own history, guards written with care have repeatedly passed
against the very defect that prompted them — a test that checked positions on a line while the
defect was the straight run between them, another that asserted a value its author had just
typed rather than that the value was valid.

**Before closing work, sweep for what it made false.** Say in your own words what behaviour
changed, then search the model for those words. What comes back is the prose that still
describes the old behaviour — and it never mentions your change, which is why only you can find
it. Most hits will be fine; reading them is the point. Reviews of this product have found a
**claim** that had quietly gone false far more often than a number that had gone stale.

Two smaller rules earn their place:

- **A part with no element is invisible.** Before calling a model complete, check that each part
  of the thing is named somewhere in it. A wrong sentence can be found by reading; a missing one
  cannot.
- **Say what you did not do.** A phase that records its residue — what was left open, and why —
  is worth more than one that reads as if everything was finished.

## Adopting it

Start small and let the practice earn its keep:

1. **Model one thing that is already confusing** — a subsystem, a domain, a deployment. Not
   everything; the parts nobody argues about do not need a model.
2. **Add the knowledge boards when the work outlives the session.** Findings, decisions and
   phases, kept beside the model they are about. An agent can create them in one call; a sketch
   needs none of it.
3. **Give an agent the key and let it read first.** Reading a model is where an agent earns
   trust; writing comes after.
4. **Review the pictures, not only the rows.** A diagram asserts relationships. Look at what it
   draws before believing what it says.
5. **Keep the model in version control** — the product does this for you — so *what changed and
   who changed it* is a question with an answer.

You will drop some of this. The habits that have survived longest here are the boring ones:
findings filed immediately, guards seen to fail, and the sweep before closing.

## What this is not

- **Not a methodology to adopt wholesale.** There is no certification, no ceremony and no
  required order. Take the parts that fit.
- **Not a substitute for tests, reviews or thinking.** It is a way to keep what you learned
  where the next person — or the next agent — will find it.

Agents working in a model get the short form of this through the product itself: `learn` teaches
it, and a knowledge kit's boards carry the rules as notices. See
*Keeping a Project's Knowledge* (in the product's manual and in-app help) for that side, and
*Inwardis for Agents* (in the product's manual and in-app help) for how an agent reads and writes a model well.

---

*This file is generated from the product manual's **Working Model-First** chapter, which ships with
Inwardis and is served to agents by its `learn` tool. Edits belong in the product, not here — a
pull request against this file would be overwritten by the next sync. Corrections and disagreements
are welcome as issues.*
