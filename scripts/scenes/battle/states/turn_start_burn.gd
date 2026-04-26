extends State

@export var turn_end_bleed: State
@export var action_input: State

func step(data: BattleStateData) -> State:
	var state: State = action_input
	var cur_unit: UnitRun = data.units[data.turn_idx]

	print("* Step Turn Start Burn")
	print("TODO: burn damage")
	
	if cur_unit.is_stunned:
		Console.print_line("* [%s] is stunned")
		state = turn_end_bleed
		cur_unit.is_stunned = false
	
	return state

func enter(data: BattleStateData) -> void:
	var cur_unit: UnitRun = data.units[data.turn_idx]

	Console.print_line("# [%s] Turn Start #" % cur_unit, Color.GREEN)
