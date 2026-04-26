extends State

@export var turn_end_poison: State

func step(data: BattleStateData) -> State:
	var state: State = turn_end_poison
	var cur_unit: UnitRun = data.units[data.turn_idx]

	print("TODO: bleed damage")
		
	return state

func enter(data: BattleStateData) -> void:
	var cur_unit: UnitRun = data.units[data.turn_idx]

	Console.print_line("# [%s] Turn End #" % cur_unit, Color.GREEN)
