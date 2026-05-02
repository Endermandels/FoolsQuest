@tool
extends Resource
class_name EffectRes

@export var targeting: Enums.EffectTargeting = Enums.EffectTargeting.OPPONENT ## Who this effect targets
@export var source_near_death_only: bool = false ## Whether the effect only triggers when the source is near death
@export var always_accurate: bool = false: ## Whether the effect always triggers
	set(val):
		always_accurate = val
		notify_property_list_changed()
@export var accuracy_percent: int = 100 ## Percent chance for the effect to trigger

func _validate_property(property: Dictionary) -> void:
	if property.name == "accuracy_percent":
		if always_accurate:
			property.usage = PROPERTY_USAGE_NO_EDITOR
