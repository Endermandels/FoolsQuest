@tool
extends EffectRes
class_name ResistanceRes

@export var type: Enums.StatusEffect = Enums.StatusEffect.POISON
@export_range(1, 5) var duration: int = 1
