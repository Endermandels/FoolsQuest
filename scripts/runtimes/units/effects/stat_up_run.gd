extends EffectRun
class_name StatUpRun

var stat_type: Constants.StatType
var amount: int

func init(res: StatUpRes) -> void:
	self.stat_type = res.stat_type
	self.amount = res.amount

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	if not target.is_alive: return res

	var stat_str: String = Constants.StatType.find_key(stat_type).to_lower()

	if stat_type == Constants.StatType.HP or stat_type == Constants.StatType.MP:
		var amount_gained = min(amount, target.get("base_" + stat_str) - target.get(stat_str))
		
		if amount_gained > 0:
			target.set(stat_str, target.get(stat_str) + amount_gained)
			Console.print_line("* [%s] gained [%d] %s" % [target, amount_gained, stat_str.to_upper()])
			res = true
	else:
		target.set(stat_str, target.get(stat_str) + amount)
		Console.print_line("* [%s] gained [%d] %s" % [target, amount, stat_str.to_upper()])
		res = true

	return res
