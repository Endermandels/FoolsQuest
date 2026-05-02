extends EffectRun
class_name BlindRun

var duration: int

func init(res: BlindRes) -> void:
	self.duration = res.duration

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false
	var description: String = "vision dimmed"

	assert(target.is_alive)

	# Can't blind an already blind unit
	if not target.is_blind:
		target.blind_turns_left += duration
		Console.print_line("* [%s] %s" % [target, description])
		
		res = true

	return res
