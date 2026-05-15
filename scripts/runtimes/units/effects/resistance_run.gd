extends EffectRun
class_name ResistanceRun

var duration: int
var type: Constants.StatusEffect

func init(res: ResistanceRes) -> void:
	self.duration = res.duration
	self.type = res.type

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	assert(target.is_alive)

	if type == Constants.StatusEffect.POISON:
		target.poison_resistance_turns_left += duration
		Console.print_line("* [%s] gained [%d] turns of Poison resistance" % [target, duration])
		res = true
	elif type == Constants.StatusEffect.BLEED:
		target.bleed_resistance_turns_left += duration
		Console.print_line("* [%s] gained [%d] turns of Bleed resistance" % [target, duration])
		res = true
	elif type == Constants.StatusEffect.BLIND:
		target.blindness_resistance_turns_left += duration
		Console.print_line("* [%s] gained [%d] turns of Blindness resistance" % [target, duration])
		res = true
	elif type == Constants.StatusEffect.BURN:
		target.burn_resistance_turns_left += duration
		Console.print_line("* [%s] gained [%d] turns of Burn resistance" % [target, duration])
		res = true
	elif type == Constants.StatusEffect.STUN:
		target.stun_resistance_turns_left += duration
		Console.print_line("* [%s] gained [%d] turns of Stun resistance" % [target, duration])
		res = true
	else:
		push_error("! Unknown type: %s" % type)

	return res
