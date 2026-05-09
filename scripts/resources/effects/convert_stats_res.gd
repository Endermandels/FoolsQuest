@tool
extends EffectRes
class_name ConvertStatsRes

@export var from_stat: Enums.StatType = Enums.StatType.HP:
	set(val):
		from_stat = val
		if to_stat == val:
			if val == Enums.StatType.HP:
				to_stat = Enums.StatType.MP
			else:
				to_stat = Enums.StatType.HP
@export var to_stat: Enums.StatType = Enums.StatType.MP:
	set(val):
		to_stat = val
		if from_stat == val:
			if val == Enums.StatType.MP:
				from_stat = Enums.StatType.HP
			else:
				from_stat = Enums.StatType.MP
@export_range(1, 100) var amount: int = 1
