extends EffectRun
class_name BlindRun

var duration: int

func init(res: BlindRes) -> void:
	self.duration = res.duration

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	assert(target.is_alive)

	if not target.resists_blindness:
		# Can't blind an already blind unit
		if not target.is_blind:
			target.blind_turns_left += duration
			Console.print_line("* [%s] gained [%d] Blindness" % [target, duration])
			res = true
	else:
		Console.print_line("* [%s] resists Blindness" % target)

	return res
