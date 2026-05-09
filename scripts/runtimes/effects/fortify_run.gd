extends EffectRun
class_name FortifyRun

var amount: int

func init(res: FortifyRes) -> void:
	self.amount = res.amount

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	assert(target.is_alive)

	target.def += amount
	Console.print_line("* [%s] gained [%d] DEF" % [target, amount])
	res = true

	return res
