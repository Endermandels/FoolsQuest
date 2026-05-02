extends EffectRun
class_name BleedRun

var duration: int

func init(res: BleedRes) -> void:
	self.duration = res.duration

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	assert(target.is_alive)

	if not target.resists_bleed:
		target.bleed_turns_left += duration
		Console.print_line("* [%s] gained [%d] Bleed" % [target, duration])
		res = true
	else:
		Console.print_line("* [%s] resists Bleed" % target)

	return res
