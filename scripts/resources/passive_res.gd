@tool
extends Resource
class_name PassiveRes

@export_placeholder("Sharp Fangs") var name_id: String = ""
@export var type: Enums.PassiveType = Enums.PassiveType.POST_ATTACK ## When this passive triggers during an attack
@export var effects: Array[EffectRes] = [] ## This passive's effects

func _to_string() -> String:
	return name_id
