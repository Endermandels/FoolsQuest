@tool
extends Resource
class_name BattleLogicRes

@export var evasion_miss_chance_scale: int = 10 ## Every point of SPD increases evasion by this percentage
@export var evasion_miss_chance_max: int = 70 ## Maximum percent chance of evading
@export_group("Status Effects")
@export var burn_dmg_res: DMGRes
@export var poison_dmg_res: DMGRes
@export var bleed_dmg_res: DMGRes
@export_range(0, 100) var blind_miss_chance: int = 70 ## Flat blindness percent chance of missing
