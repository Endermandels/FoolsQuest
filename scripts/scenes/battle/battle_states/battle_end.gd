extends State

func step(_data: BattleStateData) -> State:
	return null

func enter(data: BattleStateData) -> void:
	Console.print_line("# Battle End #", Color.GREEN)
	for u in data.units:
		if u.is_player:
			if u.is_alive:
				Console.print_line("* Victory!")
			else:
				Console.print_line("* Defeat")
			break
