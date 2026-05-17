@tool
extends AbilityRes
class_name SpecialRes

@export var once_per_battle: bool = false
@export_range(1, 10) var mp_cost: int = 1
@export var effects: Array[EffectRes] = []

func _to_string() -> String:
	return name_id
