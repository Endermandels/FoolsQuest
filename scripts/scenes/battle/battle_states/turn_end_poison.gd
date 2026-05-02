extends State

@export var turn_end_last: State
@export var battle_end: State

func step(data: BattleStateData) -> State:
	var state: State = turn_end_last
	var cur_unit: UnitRun = data.units[data.turn_idx]

	print("* Step Turn End Poison")

	if cur_unit.is_poisoned:
		Console.print_line("* [%s] is hurt by poison" % cur_unit)

		var dmg_res: DMGRes = DMGRes.new()
		dmg_res.dmg = data.status_effects_res.poison_dmg
		dmg_res.is_pure = true
		dmg_res.targeting = Enums.EffectTargeting.SELF
		var dmg_run: DMGRun = EffectRun.from_resource(dmg_res)

		dmg_run.apply(cur_unit)
		if data.has_death_occurred():
			state = battle_end

	return state
