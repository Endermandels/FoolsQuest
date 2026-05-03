extends State

@export var turn_end_bleed: State
@export var battle_end: State

## Returns whether a death has occurred.
func _trigger_passives(cur_unit: UnitRun, defender: UnitRun, ptype: Enums.PassiveType) -> bool:
	var has_death_occurred: bool = false
	var all_passives: Array[PassiveRes] = cur_unit.passives + cur_unit.temp_passives

	for p: PassiveRes in all_passives:
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
		var miss: bool = false
		
		# Blind miss chance
		if cur_unit.is_blind:
			miss = Helper.rnd_succeeded(data.status_effects_res.blind_miss_chance)
			Console.print_line("* [%s] flailed blindly and %s" % [cur_unit, "missed" if miss else "hit"])
			cur_unit.blind_turns_left -= 1
			if not cur_unit.is_blind:
				Console.print_line("* [%s] sight returned" % cur_unit)
		
		if not miss:
			var dmg_res: DMGRes = DMGRes.new()
			dmg_res.dmg = cur_unit.atk
			dmg_res.targeting = Enums.EffectTargeting.OPPONENT
			dmg_res.always_accurate = true
			var dmg_run: DMGRun = EffectRun.from_resource(dmg_res)
			
			var dmg_successful = dmg_run.apply(cur_unit, defender) # Make sure the player actually did DMG to the defender's HP

			if dmg_successful:
				if data.has_death_occurred():
					state = battle_end
				else:
					# Gain MP
					var mp_gained: bool = cur_unit.mp < cur_unit.base_mp
					cur_unit.mp += 1
					
					if mp_gained:
						Console.print_line("* [%s] restored 1 MP" % cur_unit)

					# Trigger Passives
					if _trigger_passives(cur_unit, defender, Enums.PassiveType.POST_DEFENSE):
						state = battle_end
					
					elif _trigger_passives(cur_unit, defender, Enums.PassiveType.POST_ATTACK):
						state = battle_end

	return state

func enter(data: BattleStateData) -> void:
	var cur_unit: UnitRun = data.units[data.turn_idx]

	Console.print_line("# [%s] Attack #" % cur_unit, Color.GREEN)
