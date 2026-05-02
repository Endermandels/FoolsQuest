extends State

@export var turn_start_first: State

func step(_data: BattleStateData) -> State:
	var state: State = turn_start_first

	print("* Step Turn End Last")

	return state

func exit(data: BattleStateData) -> void:
	data.next_turn()
