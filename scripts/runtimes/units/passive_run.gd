extends AbilityRun
class_name PassiveRun

# Resource Attributes
var type: Constants.PassiveType
var effects: Array[EffectRes]

func _init(res: PassiveRes) -> void:
	self.name_id = res.name_id
	self.type = res.type
	self.effects = res.effects.duplicate_deep()

func _to_string() -> String:
	return name_id
