extends EffectRun
class_name PureAttackRun

func init(_res: PureAttackRes) -> void:
	pass

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	assert(target.is_alive)

	if not target.attack_is_pure:
		target.attack_is_pure = true
		Console.print_line("* [%s] next attack is pure" % [target])
		res = true

	return res
