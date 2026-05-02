# Description
This state shall:
- Set unit's ATK, DEF and SPD stats back to base values.
- Report who won.
- If the player won:
  - Increase the player stats according to the defeated unit's Loot.
  - Give the player ability choices from the defeated unit's Loot, one Passive and one Special.
  - If the player has any of the listed abilities, it will be unavailable for selection.
  - If the player has both of the listed abilities, the player will not gain new abilities.
  - Transition to Location Selection Scene
- If the player lost:
  - Transition to Defeat Scene

# Milestones
- [0003](../../../../milestones/0003%20-%20Battle.md)
- [0004](../../../milestones/0004%20-%20Loop.md)