extends EffectRun
class_name DMGRun

var is_pure: bool
var dmg: int

func init(res: DMGRes) -> void:
	self.is_pure = res.is_pure
	self.dmg = res.dmg

func _apply(_source: UnitRun, target: UnitRun) -> void:
	assert(target.is_alive)

	var dmg_adj = dmg

	if not is_pure:
		dmg_adj -= target.def
	
	target.hp -= dmg_adj
	Console.print_line("* [%s] took [%d] DMG" % [target, dmg])
