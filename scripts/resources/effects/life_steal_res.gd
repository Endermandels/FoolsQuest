@tool
extends EffectRes
class_name LifeStealRes

@export_range(1, 100) var dmg: int = 1
@export_range(5, 100, 5) var percent_hp_steal: int = 50
@export_range(1, 100) var mp_restored: int = 1
