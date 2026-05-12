@tool
extends EffectRes
class_name ConvertStatsRes

@export var from_stat: Constants.StatType = Constants.StatType.HP:
	set(val):
		from_stat = val
		if to_stat == val:
			if val == Constants.StatType.HP:
				to_stat = Constants.StatType.MP
			else:
				to_stat = Constants.StatType.HP
@export var to_stat: Constants.StatType = Constants.StatType.MP:
	set(val):
		to_stat = val
		if from_stat == val:
			if val == Constants.StatType.MP:
				from_stat = Constants.StatType.HP
			else:
				from_stat = Constants.StatType.MP
@export_range(1, 100) var amount: int = 1
