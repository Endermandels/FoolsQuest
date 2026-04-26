extends State

@export var turn_end_bleed: State
@export var battle_end: State

## Returns whether a death has occurred.
func _trigger_passives(cur_unit: UnitRun, defender: UnitRun, ptype: Enums.PassiveType) -> bool:
	var has_death_occurred: bool = false

	for p: PassiveRes in cur_unit.passives:
		if p.type == ptype:
			for e_res: EffectRes in p.effects:
				var e_run = EffectRun.from_resource(e_res)

				if ptype == Enums.PassiveType.PRE_ATTACK || ptype == Enums.PassiveType.POST_ATTACK:
					e_run.apply(cur_unit, defender)
				else:
					e_run.apply(defender, cur_unit)

				if not cur_unit.is_alive or not defender.is_alive:
					has_death_occurred = true
					break

	return has_death_occurred

func step(data: BattleStateData) -> State:
	var state: State = turn_end_bleed
	var cur_unit: UnitRun = data.units[data.turn_idx]
	var defender: UnitRun = data.units[1 - data.turn_idx]

	print("* Step Attack")
	if _trigger_passives(cur_unit, defender, Enums.PassiveType.PRE_ATTACK):
		state = battle_end
	
	elif _trigger_passives(cur_unit, defender, Enums.PassiveType.PRE_DEFENSE):
		state = battle_end
	
	else:
		var dmg_res: DMGRes = DMGRes.new()
		dmg_res.dmg = cur_unit.atk
		var dmg_run: DMGRun = EffectRun.from_resource(dmg_res)

		dmg_run.apply(cur_unit, defender)
		if data.has_death_occurred():
			state = battle_end
		else:
			if _trigger_passives(cur_unit, defender, Enums.PassiveType.POST_DEFENSE):
				state = battle_end
			
			elif _trigger_passives(cur_unit, defender, Enums.PassiveType.POST_ATTACK):
				state = battle_end

	return state

func enter(data: BattleStateData) -> void:
	var cur_unit: UnitRun = data.units[data.turn_idx]

	Console.print_line("# [%s] Attack #" % cur_unit, Color.GREEN)
