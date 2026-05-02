extends EffectRun
class_name BurnRun

var duration: int

func init(res: BurnRes) -> void:
	self.duration = res.duration

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false
	var description: String = "caught on fire" if not target.is_burning else "endured a flury of flames"

	assert(target.is_alive)

	if not target.is_immune_to_burn:
		target.burn_turns_left += duration
		Console.print_line("* [%s] %s" % [target, description])
		res = true
	else:
		Console.print_line("* [%s] is inflammable")

	return res
