extends EffectRun
class_name PoisonRun

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	assert(target.is_alive)

	if not target.is_immune_to_poison:
		if not target.is_poisoned:
			target.is_poisoned = true
			Console.print_line("* [%s] suffered poisoning" % [target])
			res = true
	else:
		Console.print_line("* [%s] is immune to poison" % target)

	return res