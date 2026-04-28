extends EffectRun
class_name BurnRun

var duration: int

func init(res: BurnRes) -> void:
	self.duration = res.duration

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	assert(target.is_alive)

	target.burn_turns_left += duration
	Console.print_line("* [%s] caught on fire" % [target])
	
	res = true

	return res
