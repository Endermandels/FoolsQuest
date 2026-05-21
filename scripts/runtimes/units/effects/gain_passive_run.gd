extends EffectRun
class_name GainPassiveRun

var passive: PassiveRes

func init(res: GainPassiveRes) -> void:
	self.passive = res.passive.duplicate_deep()

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false
	
	if not target.is_alive: return res

	target.temp_passives.append(PassiveRun.new(passive))
	Console.print_line("* [%s] gained [%s]" % [target, passive])
	res = true

	return res
