extends State

@export var attack: State
@export var special: State

var attack_selected: bool = true ## Save the player's selected action for player's convenience
var choosing_attack_or_special: bool = true
var player_special_idx_save: int = 0 ## Save the player's selected special for player's convenience

func _print_action_prompt() -> void:
	Console.print_line("> Choose an Action:", Color.ORANGE)
	Console.print_line("1. Attack", Color.ORANGE)
	Console.print_line("2. Special", Color.ORANGE)
	Console.print_line("* Currently selecting [%s]" % ("Attack" if attack_selected else "Special"))

func _print_special_prompt(cur_unit: UnitRun, data: BattleStateData) -> void:
	Console.print_line("> Choose a Special:", Color.ORANGE)
	for i in range(cur_unit.specials.size()):
		var special: SpecialRun = cur_unit.specials[i]
		var valid_special: bool = _valid_special(cur_unit, cur_unit.specials[i])
		Console.print_line("%d. %s (%d/%d MP)" % [i + 1, special, cur_unit.mp, special.mp_cost], Color.ORANGE if valid_special else Color.RED)
	Console.print_line("* Currently selecting [%s]" % cur_unit.specials[data.selected_special_idx])

func _valid_special(cur_unit: UnitRun, special: SpecialRun) -> bool:
	return (special.mp_cost <= cur_unit.mp) and (not special.once_per_battle or not special.used)

## Returns whether to Special (true) or Attack (false). Cannot use Special if there are no valid specials available.
func _get_ai_action(cur_unit: UnitRun, _data: BattleStateData) -> bool:
	var res: bool = false
	var ai: AIRes = cur_unit.ai
	var special_valid: bool = cur_unit.specials.any(func (x: SpecialRun): return _valid_special(cur_unit, x))

	if cur_unit.first_turn_action and ai.act_on_first_turn:
		# First Turn
		res = ai.first_turn_is_special
	elif cur_unit.is_near_death and ai.special_near_death:
		# Near Death
		res = true
	else:
		# Random Chance
		res = not Helper.rnd_succeeded(ai.attack_percent)

	return special_valid and res

func step(data: BattleStateData) -> State:
	var state: State = null
	var cur_unit: UnitRun = data.units[data.turn_idx]

	print("* Step Action Input")

	if cur_unit.is_player:
		data.selected_special_idx = player_special_idx_save

		if choosing_attack_or_special:
			# Attack or Special?
			if data.input_data.inputs[BattleInputData.InputType.LEFT] or data.input_data.inputs[BattleInputData.InputType.RIGHT]:
				data.input_data.clear_inputs()
				attack_selected = not attack_selected
				Console.print_line("* Currently selecting [%s]" % ("Attack" if attack_selected else "Special"))
			
			elif data.input_data.inputs[BattleInputData.InputType.CONFIRM]:
				data.input_data.clear_inputs()

				if attack_selected:
					state = attack
				elif cur_unit.specials.size() > 0: # Make sure player has any specials at all
					choosing_attack_or_special = false
					_print_special_prompt(cur_unit, data)
				else:
					Console.print_line("! [%s] does not have any Specials" % cur_unit, Color.RED)

		else:
			# Which Special?
			if data.input_data.inputs[BattleInputData.InputType.BACK]:
				data.input_data.clear_inputs()
				choosing_attack_or_special = true
				_print_action_prompt()
			
			elif data.input_data.inputs[BattleInputData.InputType.LEFT]:
				data.input_data.clear_inputs()
				data.selected_special_idx -= 1
				if data.selected_special_idx < 0:
					data.selected_special_idx = cur_unit.specials.size() - 1
				Console.print_line("* Currently selecting [%s]" % cur_unit.specials[data.selected_special_idx])
			
			elif data.input_data.inputs[BattleInputData.InputType.RIGHT]:
				data.input_data.clear_inputs()
				data.selected_special_idx += 1
				if data.selected_special_idx > cur_unit.specials.size() - 1:
					data.selected_special_idx = 0
				Console.print_line("* Currently selecting [%s]" % cur_unit.specials[data.selected_special_idx])
			
			elif data.input_data.inputs[BattleInputData.InputType.CONFIRM]:
				data.input_data.clear_inputs()
				if _valid_special(cur_unit, cur_unit.specials[data.selected_special_idx]):
					state = special
				else:
					Console.print_line("! Invalid selection", Color.RED)

		player_special_idx_save = data.selected_special_idx	
	else:
		if _get_ai_action(cur_unit, data):
			var valid_special_idxs: Array[int] = []

			# Filter for valid specials
			for i: int in range(cur_unit.specials.size()):
				if cur_unit.specials[i].mp_cost <= cur_unit.mp:
					valid_special_idxs.append(i)
			
			state = special
			data.selected_special_idx = valid_special_idxs.pick_random()
		else:
			state = attack
	
	return state

func enter(data: BattleStateData) -> void:
	print("* Entered Action Input")
	if data.units[data.turn_idx].is_player:
		data.input_data.allow_inputs = true
		data.input_data.clear_inputs()
		_print_action_prompt()

func exit(data: BattleStateData) -> void:
	var cur_unit: UnitRun = data.units[data.turn_idx]
	
	data.input_data.allow_inputs = false
	choosing_attack_or_special = true # Should always choose between Attack or Special first
	cur_unit.first_turn_action = false
