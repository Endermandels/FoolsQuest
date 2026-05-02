@tool
extends Resource
class_name SpecialRes

@export var name_id: String = ""
@export_range(1, 10) var mp_cost: int = 1
@export var effects: Array[EffectRes] = []

func _to_string() -> String:
	return name_id
