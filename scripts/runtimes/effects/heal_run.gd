extends EffectRun
class_name HealRun

var amount: int

func init(res: HealRes) -> void:
	self.amount = res.amount

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	assert(target.is_alive)

	var hp_gained = min(amount, target.base_hp - target.hp)
	
	if hp_gained > 0:
		target.hp += hp_gained
		Console.print_line("* [%s] healed [%d] HP" % [target, hp_gained])
		res = true

	return res
