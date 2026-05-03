@tool
extends Resource
class_name StatusEffectsRes

@export var burn_dmg_res: DMGRes
@export var poison_dmg_res: DMGRes
@export var bleed_dmg_res: DMGRes
@export_range(0, 100) var blind_miss_chance: int = 70
