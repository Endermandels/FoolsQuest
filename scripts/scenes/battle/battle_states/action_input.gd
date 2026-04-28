extends State

@export var attack: State
@export var special: State

var attack_selected: bool = true
var choosing_attack_or_special: bool = true

func _print_action_prompt() -> void:
	Console.print_line("> Choose an Action:", Color.ORANGE)
	Console.print_line("1. Attack", Color.ORANGE)
	Console.print_line("2. Special", Color.ORANGE)
	Console.print_line("* Currently selecting [%s]" % ("Attack" if attack_selected else "Special"))

func _print_special_prompt(cur_unit: UnitRun, data: BattleStateData) -> void:
	Console.print_line("> Choose a Special:", Color.ORANGE)
	for i in range(cur_unit.specials.size()):
		var special: SpecialRes = cur_unit.specials[i]
		Console.print_line("%d. %s (%d MP)" % [i + 1, special, special.mp_cost], Color.ORANGE)
	Console.print_line("* Currently selecting [%s]" % cur_unit.specials[data.selected_special_idx])

func step(data: BattleStateData) -> State:
	var state: State = null
	var cur_unit: UnitRun = data.units[data.turn_idx]

	print("* Step Action Input")

	if cur_unit.is_player:
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
				if cur_unit.mp >= cur_unit.specials[data.selected_special_idx].mp_cost:
					state = special
				else:
					Console.print_line("! [%s] insufficient MP (%d/%d)" % [cur_unit, cur_unit.mp, cur_unit.specials[data.selected_special_idx].mp_cost], Color.RED)
			
	else:
		# TODO: Add case for Special selection
		state = attack
	
	return state

func enter(data: BattleStateData) -> void:
	print("* Entered Action Input")
	if data.units[data.turn_idx].is_player:
		data.input_data.allow_inputs = true
		data.input_data.clear_inputs()
		_print_action_prompt()

func exit(data: BattleStateData) -> void:
	data.input_data.allow_inputs = false
	choosing_attack_or_special = true # Should always choose between Attack or Special first
