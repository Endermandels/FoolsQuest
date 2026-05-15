extends State

var is_victory: bool = false

func step(data: BattleStateData) -> State:
	if is_victory:
		var meta: LocationSetupRes = LocationSetupRes.new()
		meta.player = data.get_player()
		get_tree().set_meta(LocationSetupRes.meta_id, meta)
		get_tree().change_scene_to_file(ResourceHandler.location_scene)

	return null

func enter(data: BattleStateData) -> void:
	Console.print_line("# Battle End #", Color.GREEN)
	var player: UnitRun = data.get_player()

	# Reset ATK, DEF and SPD
	player.atk = player.base_atk
	player.def = player.base_def
	player.spd = player.base_spd

	# Reset Temporary Passives
	player.temp_passives.clear()

	# Report Win/Loss
	is_victory = player.is_alive
	if is_victory:
		Console.print_line("* Victory!")
	else:
		Console.print_line("* Defeat")
