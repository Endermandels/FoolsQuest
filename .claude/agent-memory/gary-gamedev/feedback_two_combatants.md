---
name: Two-combatant design — 1 - data.turn_idx is intentional
description: The battle system is hardcoded for exactly 2 combatants; do not flag 1 - data.turn_idx as a bug
type: feedback
---

`1 - data.turn_idx` is a deliberate design choice for getting the opponent index in a 2-combatant battle. The system is intentionally scoped to exactly two units and will not expand beyond that.

**Why:** The user confirmed this explicitly after a code review flagged it as Bug 28. It's not an indexing smell — it's the correct idiom for this architecture.

**How to apply:** Never flag `1 - data.turn_idx` as a bug or suggest replacing it with a more "flexible" opponent-lookup approach in future reviews.
