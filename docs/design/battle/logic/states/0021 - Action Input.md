# Description
This state shall:
- If the current unit is the player:
  - Ask the player for input of whether to attack or use a special.
  - If the player selects Special:
    - List all specials and whether the player has enough MP to use it.
    - Ask the player to select a valid Special.
    - If the player selects a valid Special, store the selected special and transition to Special.
  - If the player selects Attack, transition to Attack
- Otherwise:
  - If out of the current unit's valid specials (i.e. MP >= Cost), store a randomly selected special and transition to Special.
  - Otherwise, transition to Attack.

# Milestones
- [0003](../../../../milestones/0003%20-%20Battle.md)
