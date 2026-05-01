extends EffectRun
class_name LifeStealRun

var dmg: int
var percent_hp_steal: int
var mp_restored: int

func init(res: LifeStealRes) -> void:
	self.dmg = res.dmg
	self.percent_hp_steal = res.percent_hp_steal
	self.mp_restored = res.mp_restored

func _apply(source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	assert(target.is_alive and source.is_alive)

	var heal_amount: int = roundi(target.hp * (float(percent_hp_steal) / 100.0))
	var target_was_full_hp: bool = target.hp == target.base_hp
	var hp_lost: int = max(dmg - target.def, 0)

	if hp_lost > 0:
		target.hp -= hp_lost
		Console.print_line("* [%s] took [%d] DMG" % [target, hp_lost])

		# HP heal
		var amount_healed: int = min(heal_amount, source.base_hp - source.hp)

		if amount_healed > 0:
			source.hp += amount_healed
			Console.print_line("* [%s] healed [%d] HP" % [source, amount_healed])

		# MP restore
		if target_was_full_hp:
			var amount_restored: int = min(mp_restored, source.base_mp - source.mp)

			if amount_restored > 0:
				source.mp += amount_restored
				Console.print_line("* [%s] restored [%d] MP" % [source, amount_restored])

		res = true

	return res
