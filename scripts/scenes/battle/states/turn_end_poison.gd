extends State

@export var turn_start_burn: State

func step(data: BattleStateData) -> State:
	var state: State = turn_start_burn
	var cur_unit: UnitRun = data.units[data.turn_idx]

	print("* Step Turn End Poison")
	print("TODO: poison damage")

	return state

func exit(data: BattleStateData) -> void:
	data.next_unit()
