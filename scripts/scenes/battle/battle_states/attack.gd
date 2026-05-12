extends State

@export var turn_end_bleed: State
@export var battle_end: State

func step(data: BattleStateData) -> State:
	var state: State = turn_end_bleed
	var cur_unit: UnitRun = data.units[data.turn_idx]
	var defender: UnitRun = data.units[1 - data.turn_idx]

	print("* Step Attack")
	if data.trigger_passives(cur_unit, defender, Constants.PassiveType.PRE_ATTACK):
		state = battle_end
	
	elif data.trigger_passives(defender, cur_unit, Constants.PassiveType.PRE_DEFENSE):
		state = battle_end
	
	else:
		# Evasion
		var miss: bool = Helper.rnd_succeeded(min(defender.spd * data.battle_logic_res.evasion_miss_chance_scale, data.battle_logic_res.evasion_miss_chance_max))

		# Blindness
		if not miss and cur_unit.is_blind:
			miss = Helper.rnd_succeeded(data.battle_logic_res.blind_miss_chance)
		
		if not miss:
			var dmg_res: DMGRes = DMGRes.new()
			dmg_res.is_pure = cur_unit.attack_is_pure
			dmg_res.dmg = cur_unit.atk
			dmg_res.targeting = Constants.EffectTargeting.OPPONENT
			dmg_res.always_accurate = true
			var dmg_run: DMGRun = EffectRun.from_resource(dmg_res)
			
			var dmg_successful = dmg_run.apply(cur_unit, defender) # Make sure the player actually did DMG to the defender's HP

			if data.has_death_occurred():
				state = battle_end
			else:
				# Reset attack is pure
				cur_unit.attack_is_pure = false

				# Defense passives trigger regardless of a failed attack on the player's part
				if data.trigger_passives(defender, cur_unit, Constants.PassiveType.POST_DEFENSE):
					state = battle_end
				elif dmg_successful:
					# Gain MP
					var mp_gained: bool = cur_unit.mp < cur_unit.base_mp
					cur_unit.mp += 1
					
					if mp_gained:
						Console.print_line("* [%s] restored 1 MP" % cur_unit)
					
					# Offensive passives trigger only on successful attack
					if data.trigger_passives(cur_unit, defender, Constants.PassiveType.POST_ATTACK):
						state = battle_end
		else:
			if cur_unit.is_blind:
				Console.print_line("* [%s] missed [%s]" % [cur_unit, defender])
			else:
				Console.print_line("* [%s] evaded the attack" % defender)

		if state != battle_end and cur_unit.is_blind:
			cur_unit.blind_turns_left -= 1
			if not cur_unit.is_blind:
				Console.print_line("* [%s] sight returned" % cur_unit)

	return state

func enter(data: BattleStateData) -> void:
	var cur_unit: UnitRun = data.units[data.turn_idx]

	Console.print_line("# [%s] Attack #" % cur_unit, Color.GREEN)
