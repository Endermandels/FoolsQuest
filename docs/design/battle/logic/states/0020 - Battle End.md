# Description
This state shall:
- Set units' ATK, DEF and SPD stats back to base values.
- Clear units' temporary passives.
- Report who won.
- If the player won:
  - Increase the player stats according to the defeated unit's Loot.
  - Give the player ability choices from the defeated unit's Loot, one Passive and one Special.
  - If the player has any of the listed abilities, it will be unavailable for selection.
  - If the player has both of the listed abilities, the player will not gain new abilities.
  - Create a [Location Setup Resource](../../../location%20selection/logic/0051%20-%20Setup%20Resource.md) with all elements filled.
  - Store the Location Setup Resource in the scene tree meta data.
  - Transition to Location Selection Scene.
- If the player lost:
  - Transition to Defeat Scene.

# Milestones
- [0003](../../../../milestones/0003%20-%20Battle.md)
- [0004](../../../milestones/0004%20-%20Loop.md)