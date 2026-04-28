extends EffectRun
class_name PoisonRun

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	assert(target.is_alive)

	if not target.is_poisoned:
		target.is_poisoned = true
		Console.print_line("* [%s] is poisoned" % [target])
		res = true

	return res