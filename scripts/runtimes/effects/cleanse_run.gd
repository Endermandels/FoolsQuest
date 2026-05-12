extends EffectRun
class_name CleanseRun

var type: Constants.StatusEffect

func init(res: CleanseRes) -> void:
	self.type = res.type

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	assert(target.is_alive)

	if type == Constants.StatusEffect.POISON:
		if target.is_poisoned:
			target.is_poisoned = false
			Console.print_line("* [%s] was cured of Poison" % target)
			res = true
	elif type == Constants.StatusEffect.BLEED:
		if target.is_bleeding:
			target.bleed_turns_left = 0
			Console.print_line("* [%s] was cured of Bleeding" % target)
			res = true
	elif type == Constants.StatusEffect.BLIND:
		if target.is_blind:
			target.blind_turns_left = 0
			Console.print_line("* [%s] was cured of Blindness" % target)
			res = true
	elif type == Constants.StatusEffect.BURN:
		if target.is_burning:
			target.burn_turns_left = 0
			Console.print_line("* [%s] was cured of Burn" % target)
			res = true
	elif type == Constants.StatusEffect.STUN:
		if target.is_stunned:
			target.is_stunned = false
			Console.print_line("* [%s] was cured of Stun" % target)
			res = true
	else:
		push_error("! Unknown status effect: %s" % type)

	return res
