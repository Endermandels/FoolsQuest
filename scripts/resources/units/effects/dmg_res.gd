@tool
extends EffectRes
class_name DMGRes

@export var is_pure: bool = false ## Whether the DMG bypasses DEF
@export_range(1, 100) var dmg: int = 1
