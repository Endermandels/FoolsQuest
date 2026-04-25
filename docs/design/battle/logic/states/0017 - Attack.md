# Description
This state shall:
- If the current unit is blind, X% chance to clear blindness.
- If the current unit is blind, set unit's chance to miss attack to X%.
- Apply current unit's Proactive Attack Passives.
- Apply defender's Proactive Defense Passives.
- Check unit's chance to miss attack.  If the unit misses the ATK, transition to Turn End Bleed. Set chance to miss attack to 0.
- Deal X DMG to the defender where X is the current unit's ATK.
- Gain 1 MP.
- Apply defender's Reactive Defense Passives.
- Apply current unit's Reactive Attack Passives.
- If the defender dies, transition to Battle End.
- Transition to Turn End Bleed.

Note: The ordering of defensive or attack passives should be easy to swap in balancing.

# Milestones
- [0003](../../../../milestones/0003%20-%20Battle.md)