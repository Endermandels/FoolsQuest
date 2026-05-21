extends EffectRun
class_name PoisonRun

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	if not target.is_alive: return res

	if not target.resists_poison:
		if not target.is_poisoned:
			target.is_poisoned = true
			Console.print_line("* [%s] suffered poisoning" % [target])
			res = true
	else:
		Console.print_line("* [%s] resists Poison" % target)

	return res