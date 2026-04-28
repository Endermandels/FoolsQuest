extends State

@export var turn_end_bleed: State
@export var action_input: State
@export var battle_end: State

func step(data: BattleStateData) -> State:
	var state: State = action_input
	var cur_unit: UnitRun = data.units[data.turn_idx]

	print("* Step Turn Start Burn")

	if cur_unit.is_burning:
		assert(cur_unit.burn_turns_left > 0)

		Console.print_line("* [%s] is on fire" % cur_unit)

		var dmg_res: DMGRes = DMGRes.new()
		dmg_res.dmg = data.status_effects_res.burn_dmg
		dmg_res.targeting = Enums.EffectTargeting.SELF
		var dmg_run: DMGRun = EffectRun.from_resource(dmg_res)

		dmg_run.apply(cur_unit)
		if data.has_death_occurred():
			state = battle_end
		else:
			cur_unit.burn_turns_left -= 1

			if not cur_unit.is_burning:
				Console.print_line("* [%s] is no longer on fire" % cur_unit)
	
			if cur_unit.is_stunned:
				Console.print_line("* [%s] is stunned")
				state = turn_end_bleed
				cur_unit.is_stunned = false
	
	return state

func enter(data: BattleStateData) -> void:
	var cur_unit: UnitRun = data.units[data.turn_idx]

	Console.print_line("# [%s] Turn Start #" % cur_unit, Color.GREEN)
