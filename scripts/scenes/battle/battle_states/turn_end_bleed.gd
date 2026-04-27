extends State

@export var turn_end_poison: State
@export var battle_end: State

func step(data: BattleStateData) -> State:
	var state: State = turn_end_poison
	var cur_unit: UnitRun = data.units[data.turn_idx]
	
	print("* Step Turn End Bleed")

	if cur_unit.is_bleeding:
		assert(cur_unit.bleed_turns_left > 0)

		Console.print_line("* [%s] is hurt by blood loss" % cur_unit)

		var dmg_res: DMGRes = DMGRes.new()
		dmg_res.dmg = data.status_effects_res.bleed_dmg
		dmg_res.is_pure = true
		dmg_res.targeting = Enums.EffectTargeting.SELF
		var dmg_run: DMGRun = EffectRun.from_resource(dmg_res)

		dmg_run.apply(cur_unit)
		if data.has_death_occurred():
			state = battle_end
			
		cur_unit.bleed_turns_left -= 1

		if not cur_unit.is_bleeding:
			Console.print_line("* [%s] has stopped bleeding" % cur_unit)
		
	return state

func enter(data: BattleStateData) -> void:
	var cur_unit: UnitRun = data.units[data.turn_idx]

	Console.print_line("# [%s] Turn End #" % cur_unit, Color.GREEN)
