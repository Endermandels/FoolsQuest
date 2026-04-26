extends State

@export var attack: State
@export var special: State

func step(data: BattleStateData) -> State:
	var state: State = null
	var cur_unit: UnitRun = data.units[data.turn_idx]

	print("* Step Action Input")
	if cur_unit.is_player:
		if not data.player_confirm:
			Console.print_line(
				"> Attack or Special? (Selected: %s) Enter '/l' or '/r' to change selection. Enter '/c' to confirm." 
				% ("Attack" if data.is_attack_action else "Special"), 
				Color.ORANGE
			)
		else:
			data.player_confirm = false
			state = attack if data.is_attack_action else special
	else:
		# TODO: Add case for Special selection
		state = attack
	
	return state

func enter(_data: BattleStateData) -> void:
	print("* Entered Action Input")
