extends EffectRun
class_name BurnRun

var duration: int

func init(res: BurnRes) -> void:
	self.duration = res.duration

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	if not target.is_alive: return res

	if not target.resists_burn:
		target.burn_turns_left += duration
		Console.print_line("* [%s] gained [%d] Burn" % [target, duration])
		res = true
	else:
		Console.print_line("* [%s] resists Burn" % target)

	return res
