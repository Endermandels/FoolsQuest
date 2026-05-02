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
  - Check the current unit's ai given the current state to see whether to attack or use a special
  - If special is selected, store a randomly selected valid special and transition to Special.
  - Otherwise, transition to Attack.

# Milestones
- [0003](../../../../milestones/0003%20-%20Battle.md)
