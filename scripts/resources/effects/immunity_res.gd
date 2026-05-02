@tool
extends EffectRes
class_name ImmunityRes

@export var immunity: Enums.Immunity = Enums.Immunity.POISON
@export_range(1, 5) var duration: int = 1
