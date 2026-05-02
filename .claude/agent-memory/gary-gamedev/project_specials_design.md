---
name: Specials design philosophy — setup/debuff/buff, not damage
description: Specials are for setup, debuffing, and buffing; Attack is the primary damage dealer
type: project
---

Specials should be geared towards setup, debuffing, and buffing — leaving the Attack Action as the primary damage dealer.

**Why:** Keeps damage output readable and predictable (one source of truth), simplifies AI decision trees (attack to deal damage, special for utility), and prevents ability bloat where every special just adds more numbers.

**How to apply:** When designing or reviewing special abilities, push back on any special that deals direct damage as its primary purpose. Damage riders as a secondary effect (e.g. lifesteal, poison ticks) are fine — but the headline effect should be utility.
