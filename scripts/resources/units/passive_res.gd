@tool
extends AbilityRes
class_name PassiveRes

@export var type: Constants.PassiveType = Constants.PassiveType.POST_ATTACK ## When this passive triggers during an attack
@export var effects: Array[EffectRes] = [] ## This passive's effects

func _to_string() -> String:
	return name_id
