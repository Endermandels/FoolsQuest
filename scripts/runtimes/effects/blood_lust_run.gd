extends EffectRun
class_name BloodLustRun

var bleed_duration_increase: int
var atk_increase: int

func init(res: BloodLustRes) -> void:
	self.bleed_duration_increase = res.bleed_duration_increase
	self.atk_increase = res.atk_increase

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	assert(target.is_alive)
	
	target.atk += atk_increase
	Console.print_line("* [%s] gained [%d] ATK" % [target, atk_increase])

	var e: BleedRes = BleedRes.new()
	var p: PassiveRes = PassiveRes.new()
	e.duration = bleed_duration_increase
	e.always_accurate = true
	e.targeting = Enums.EffectTargeting.OPPONENT
	p.type = Enums.PassiveType.POST_ATTACK
	p.effects.append(e)
	target.temp_passives.append(p)

	Console.print_line("* [%s] increased blood lust" % [target])
	res = true

	return res
