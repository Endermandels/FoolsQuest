@tool
extends EffectRes
class_name StatUpRes

@export var stat_type: Constants.StatType
@export_range(1, 100) var amount: int = 1
