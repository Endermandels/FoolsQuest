@tool
extends Resource
class_name StatusEffectsRes

@export_group("Burn")
@export_range(1, 5) var burn_dmg: int = 1
@export_group("Poison")
@export_range(1, 5) var poison_dmg: int = 1
@export_group("Blind")
@export_range(0, 100) var miss_chance: int = 70
