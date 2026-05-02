extends State

func step(_data: BattleStateData) -> State:
	return null

func enter(data: BattleStateData) -> void:
	Console.print_line("# Battle End #", Color.GREEN)
	for u in data.units:
		# Reset ATK, DEF and SPD
		u.atk = u.base_atk
		u.def = u.base_def
		u.spd = u.base_spd

		# Reset Temporary Passives
		u.temp_passives.clear()

		# Report Win/Loss
		if u.is_player:
			if u.is_alive:
				Console.print_line("* Victory!")
			else:
				Console.print_line("* Defeat")
