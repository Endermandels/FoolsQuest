@tool
extends Resource
class_name AIRes

@export_placeholder("Aggressive") var name_id: String = ""
@export var act_on_first_turn: bool = false:
	set(val):
		act_on_first_turn = val
		notify_property_list_changed()
@export var first_turn_is_special: bool = true
@export var special_near_death: bool = false
@export_range(0, 100) var attack_percent: int = 50

func _validate_property(property: Dictionary) -> void:
	if property.name == "first_turn_is_special":
		if not act_on_first_turn:
			property.usage = PROPERTY_USAGE_NO_EDITOR

func _to_string() -> String:
	return name_id
