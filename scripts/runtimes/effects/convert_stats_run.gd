extends EffectRun
class_name ConvertStatsRun

var from_stat: Enums.StatType
var to_stat: Enums.StatType
var amount: int

func init(res: ConvertStatsRes) -> void:
	self.from_stat = res.from_stat
	self.to_stat = res.to_stat
	self.amount = res.amount

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	assert(target.is_alive)
	
	var from_stat_str: String = Enums.StatType.find_key(from_stat).to_lower()
	var to_stat_str: String = Enums.StatType.find_key(to_stat).to_lower()

	if target.get(from_stat_str) >= amount:
		target.set(from_stat_str, target.get(from_stat_str) - amount)
		target.set(to_stat_str, target.get(to_stat_str) + amount)
		res = true
		Console.print_line("* [%s] converted [%d] %s into %s" % [target, amount, from_stat_str, to_stat_str])
	else:
		Console.print_line("* [%s] insufficient %s (%d/%d)" % [target, from_stat_str, target.get(from_stat_str), amount])

	return res
