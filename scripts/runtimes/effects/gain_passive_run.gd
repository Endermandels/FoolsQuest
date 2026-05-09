extends EffectRun
class_name GainPassiveRun

var passive: PassiveRes

func init(res: GainPassiveRes) -> void:
	self.passive = res.passive.duplicate_deep()

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false
	
	assert(target.is_alive)

	target.passives.append(passive)
	Console.print_line("* [%s] gained [%s]" % [target, passive])
	res = true

	return res
