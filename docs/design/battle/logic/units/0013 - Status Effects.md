# Description
Units shall have the following boolean variables indicating status effects:
- is_poisoned
- is_burning
- is_bleeding
- is_stunned
- is_blind

Units shall have the following integer variables indicating status effect terminations:
- burn_turns_left
- bleed_turns_left
- blind_turns_left

Units shall have boolean variables indicating status effect immunity for each status effect.
Units shall have integer variables indicating status effect immunity terminations for each status effect.
Units cannot have a status effect applied while the immunity variable is true.
Units that have a status effect applied when the immunity variable is set to true must set the status effect to false and clear its termination variable.

# Milestones
- [0003](../../../../milestones/0003%20-%20Battle.md)
