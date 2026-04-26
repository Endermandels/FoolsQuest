extends State

@export var turn_end_bleed: State
@export var battle_end: State

func step(data: BattleStateData) -> State:
	var state: State = turn_end_bleed
	var cur_unit: UnitRun = data.units[data.turn_idx]
	var defender: UnitRun = data.units[1 - data.turn_idx]
	
	var dmg_res: DMGRes = DMGRes.new()
	dmg_res.dmg = cur_unit.atk

	var dmg_run: DMGRun = EffectRun.from_resource(dmg_res)

	dmg_run.apply(cur_unit, defender)
	if data.has_death_occurred():
		state = battle_end

	return state

func enter(data: BattleStateData) -> void:
	var cur_unit: UnitRun = data.units[data.turn_idx]

	Console.print_line("# [%s] Attack #" % cur_unit, Color.GREEN)
