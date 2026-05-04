extends State

@export var turn_start_first: State

func step(_data: BattleStateData) -> State:
	var state: State = turn_start_first

	print("* Step Turn End Last")

	return state

func exit(data: BattleStateData) -> void:
	var cur_unit: UnitRun = data.units[data.turn_idx]
	
	cur_unit.first_turn_action = false
	data.next_turn()
