extends State

func step(data: BattleStateData) -> State:
	for u in data.units:
		if u.is_player:
			if u.is_alive:
				Console.print_line("* Victory!")
			else:
				Console.print_line("* Defeat")
	return null

func enter(_data: BattleStateData) -> void:
	Console.print_line("# Battle End #", Color.GREEN)
