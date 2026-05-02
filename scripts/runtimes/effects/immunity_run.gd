extends EffectRun
class_name ImmunityRun

var duration: int
var immunity: Enums.Immunity

func init(res: ImmunityRes) -> void:
	self.duration = res.duration
	self.immunity = res.immunity

func _apply(source: UnitRun, _target: UnitRun) -> bool:
	var res: bool = false

	assert(source.is_alive)

	if immunity == Enums.Immunity.POISON:
		if source.is_poisoned:
			Console.print_line("* [%s] was cured of Poison" % source)
		source.poison_immunity_turns_left += duration
		Console.print_line("* [%s] gained [%d] turns of Poison immunity" % [source, duration])
		res = true
	elif immunity == Enums.Immunity.BLEED:
		if source.is_bleeding:
			Console.print_line("* [%s] was cured of Bleeding" % source)
		source.bleed_immunity_turns_left += duration
		Console.print_line("* [%s] gained [%d] turns of Bleed immunity" % [source, duration])
		res = true
	elif immunity == Enums.Immunity.BLIND:
		if source.is_blind:
			Console.print_line("* [%s] was cured of Blindness" % source)
		source.blindness_immunity_turns_left += duration
		Console.print_line("* [%s] gained [%d] turns of Blindness immunity" % [source, duration])
		res = true
	elif immunity == Enums.Immunity.BURN:
		if source.is_burning:
			Console.print_line("* [%s] was cured of Burn" % source)
		source.burn_immunity_turns_left += duration
		Console.print_line("* [%s] gained [%d] turns of Burn immunity" % [source, duration])
		res = true
	elif immunity == Enums.Immunity.STUN:
		if source.is_stunned:
			Console.print_line("* [%s] was cured of Stun" % source)
		source.stun_immunity_turns_left += duration
		Console.print_line("* [%s] gained [%d] turns of Stun immunity" % [source, duration])
		res = true
	else:
		push_error("! Unknown immunity: %s" % immunity)

	return res
