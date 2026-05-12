@tool
extends EffectRes
class_name ResistanceRes

@export var type: Constants.StatusEffect = Constants.StatusEffect.POISON
@export_range(1, 100) var duration: int = 1
