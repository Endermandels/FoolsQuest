extends State

@export var turn_end_bleed: State
@export var battle_end: State

func step(data: BattleStateData) -> State:
	var state: State = turn_end_bleed
	var cur_unit: UnitRun = data.units[data.turn_idx]
	var defender: UnitRun = data.units[1 - data.turn_idx]
	var special: SpecialRun = cur_unit.specials[data.selected_special_idx]
	var successful: bool = false
	
	print("* Step Special")

	Console.print_line("* [%s] used [%s]" % [cur_unit, special])

	# Pay cost
	cur_unit.mp -= special.mp_cost
	Console.print_line("* [%s] channeled [%d] MP" % [cur_unit, special.mp_cost])

	# Mark Special as used this battle
	special.used = true
	
	if cur_unit.is_blind:
		Console.print_line("* [%s] aimed blindly" % cur_unit)
	
	# Apply Ability Effects
	for e_res: EffectRes in special.effects:
		var e_run: EffectRun = EffectRun.from_resource(e_res)

		# Blind accuracy penalty
		if cur_unit.is_blind:
			e_run.accuracy_percent -= data.status_effects_res.blind_miss_chance
		
		var temp: bool = e_run.apply(cur_unit, defender)

		successful = successful or temp
		if data.has_death_occurred():
			state = battle_end
			break

	if not successful:
		Console.print_line("* It did nothing")
	
	if cur_unit.is_blind:
		cur_unit.blind_turns_left -= 1
		if not cur_unit.is_blind:
			Console.print_line("* [%s] sight returned" % cur_unit)

	return state

func enter(data: BattleStateData) -> void:
	var cur_unit: UnitRun = data.units[data.turn_idx]

	Console.print_line("# [%s] Special #" % cur_unit, Color.GREEN)
