@tool
extends Resource
class_name PassiveRes

@export_placeholder("Sharp Fangs") var name_id: String = ""
@export var type: Enums.PassiveType = Enums.PassiveType.POST_ATTACK
@export var effects: Array[EffectRes] = []

func _to_string() -> String:
	return name_id
