extends EffectRun
class_name ImmunityRun

var duration: int
var immunity: Enums.Immunity

func init(res: ImmunityRes) -> void:
	self.duration = res.duration
	self.immunity = res.immunity

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	assert(target.is_alive)

	if immunity == Enums.Immunity.POISON:
		if target.is_poisoned:
			Console.print_line("* [%s] was cured of Poison" % target)
		target.poison_immunity_turns_left += duration
		Console.print_line("* [%s] gained [%d] turns of Poison immunity" % [target, duration])
		res = true
	elif immunity == Enums.Immunity.BLEED:
		if target.is_bleeding:
			Console.print_line("* [%s] was cured of Bleeding" % target)
		target.bleed_immunity_turns_left += duration
		Console.print_line("* [%s] gained [%d] turns of Bleed immunity" % [target, duration])
		res = true
	elif immunity == Enums.Immunity.BLIND:
		if target.is_blind:
			Console.print_line("* [%s] was cured of Blindness" % target)
		target.blindness_immunity_turns_left += duration
		Console.print_line("* [%s] gained [%d] turns of Blindness immunity" % [target, duration])
		res = true
	elif immunity == Enums.Immunity.BURN:
		if target.is_burning:
			Console.print_line("* [%s] was cured of Burn" % target)
		target.burn_immunity_turns_left += duration
		Console.print_line("* [%s] gained [%d] turns of Burn immunity" % [target, duration])
		res = true
	elif immunity == Enums.Immunity.STUN:
		if target.is_stunned:
			Console.print_line("* [%s] was cured of Stun" % target)
		target.stun_immunity_turns_left += duration
		Console.print_line("* [%s] gained [%d] turns of Stun immunity" % [target, duration])
		res = true
	else:
		push_error("! Unknown immunity: %s" % immunity)

	return res
