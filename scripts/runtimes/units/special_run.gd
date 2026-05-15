extends RefCounted
class_name SpecialRun

# Resource Attributes
var name_id: String
var once_per_battle: bool
var mp_cost: int
var effects: Array[EffectRes]

# Battle state
var used: bool = false ## Whether this special has been used this battle

func _init(res: SpecialRes) -> void:
	self.name_id = res.name_id
	self.once_per_battle = res.once_per_battle
	self.mp_cost = res.mp_cost
	self.effects = res.effects.duplicate_deep()

func _to_string() -> String:
	return name_id
