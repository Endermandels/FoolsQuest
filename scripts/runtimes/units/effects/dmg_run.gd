extends EffectRun
class_name DMGRun

var is_pure: bool
var dmg: int

func init(res: DMGRes) -> void:
	self.is_pure = res.is_pure
	self.dmg = res.dmg

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	assert(target.is_alive)

	var hp_lost = dmg

	if not is_pure:
		hp_lost -= target.def
	
	hp_lost = max(hp_lost, 0)
	
	if hp_lost > 0:
		target.hp -= hp_lost
		res = true
	else:
		Console.print_line("* [%s] defended most of the damage" % target)
		hp_lost = 1
		target.hp -= hp_lost
	Console.print_line("* [%s] lost [%d] HP" % [target, hp_lost])

	return res
