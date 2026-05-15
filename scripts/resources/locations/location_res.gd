@tool
extends Resource
class_name LocationRes

@export_placeholder("Swamp") var name_id: String = ""
@export var description: String = "" # TODO: Make use of this variable
@export var animal_groups: Array[AnimalGroupRes] = []

func _to_string() -> String:
	return name_id
