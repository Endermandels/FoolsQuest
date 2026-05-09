@tool
extends EffectRes
class_name StatDownRes

@export var stat_type: Enums.StatType
@export_range(1, 100) var amount: int = 1
