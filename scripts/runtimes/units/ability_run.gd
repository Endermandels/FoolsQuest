extends RefCounted
class_name AbilityRun

var name_id: String

func _init(res: AbilityRes) -> void:
	self.name_id = res.name_id
