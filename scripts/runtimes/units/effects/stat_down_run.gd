extends EffectRun
class_name StatDownRun

var stat_type: Constants.StatType
var amount: int

func init(res: StatDownRes) -> void:
	self.stat_type = res.stat_type
	self.amount = res.amount

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	assert(target.is_alive)

	var stat_str: String = Constants.StatType.find_key(stat_type).to_lower()

	var amount_lost = max(target.get(stat_str) - amount, 0)
	
	# ATK should never drop to 0
	if stat_type != Constants.StatType.ATK or target.get(stat_str) - amount_lost > 0:
		if amount_lost > 0:
			target.set(stat_str, target.get(stat_str) - amount_lost)
			Console.print_line("* [%s] lost [%d] %s" % [target, amount_lost, stat_str.to_upper()])
			res = true

	return res
