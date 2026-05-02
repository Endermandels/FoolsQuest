extends EffectRun
class_name BleedRun

var duration: int

func init(res: BleedRes) -> void:
	self.duration = res.duration

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false
	var description: String = "started bleeding" if not target.is_bleeding else "gashes deepened"

	assert(target.is_alive)

	if not target.is_immune_to_bleed:
		target.bleed_turns_left += duration
		Console.print_line("* [%s] %s" % [target, description])
		res = true
	else:
		Console.print_line("* [%s] wounds closed up instantly" % target)

	return res
