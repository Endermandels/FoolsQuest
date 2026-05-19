extends State

@export var turn_start_burn: State
@export var battle_end: State

func step(data: BattleStateData) -> State:
	var state: State = turn_start_burn
	var cur_unit: UnitRun = data.units[data.turn_idx]

	print("* Step Turn Start First")

	# Dragon phase shifting
	if cur_unit is DragonRun:
		if cur_unit.phase + 1 < cur_unit.phases.size():
			if float(cur_unit.hp) / float(cur_unit.base_hp) <= float(cur_unit.phases[cur_unit.phase + 1].hp_percent_trigger) / 100.0:
				Console.print_line("! [%s] %s" % [cur_unit, cur_unit.phases[cur_unit.phase + 1].phase_enter_description], Color.MAGENTA)
				cur_unit.new_phase(data.get_player())

	if data.trigger_passives(cur_unit, null, Constants.PassiveType.TURN_START_SELF):
		state = battle_end
	else:
		if cur_unit.resists_poison and cur_unit.poison_resistance_turns_left == 1:
			Console.print_line("* [%s] is susceptible to poison again" % cur_unit)

		if cur_unit.resists_bleed and cur_unit.bleed_resistance_turns_left == 1:
			Console.print_line("* [%s] is susceptible to bleeding again" % cur_unit)

		if cur_unit.resists_blindness and cur_unit.blindness_resistance_turns_left == 1:
			Console.print_line("* [%s] is susceptible to blindness again" % cur_unit)
		
		if cur_unit.resists_burn and cur_unit.burn_resistance_turns_left == 1:
			Console.print_line("* [%s] is susceptible to burning again" % cur_unit)

		if cur_unit.resists_stun and cur_unit.stun_resistance_turns_left == 1:
			Console.print_line("* [%s] is susceptible to stun again" % cur_unit)

		cur_unit.poison_resistance_turns_left -= 1
		cur_unit.burn_resistance_turns_left -= 1
		cur_unit.blindness_resistance_turns_left -= 1
		cur_unit.bleed_resistance_turns_left -= 1
		cur_unit.stun_resistance_turns_left -= 1
	
	return state

func enter(data: BattleStateData) -> void:
	var cur_unit: UnitRun = data.units[data.turn_idx]

	Console.print_line("# [%s] Turn Start #" % cur_unit, Color.GREEN)
