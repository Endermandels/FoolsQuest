extends State

var choosing_ability: bool = true

func step(data: BattleStateData) -> State:
	var state: State = null

	# Select ability
	if choosing_ability:
		print("TODO: Implement ability choosing")
		choosing_ability = false

	# Transition to Location Scene
	else:
		InputHandler.allow_inputs = false

		var meta: LocationSetupRes = LocationSetupRes.new()
		meta.player = data.get_player()
		get_tree().set_meta(LocationSetupRes.meta_id, meta)
		get_tree().change_scene_to_file(ResourceHandler.location_scene)

	return state

func enter(data: BattleStateData) -> void:
	Console.print_line("# Loot #", Color.GREEN)

	var player := data.get_player()
	var opponent := data.get_opponent()

	# Increase player stats
	var hp_increase := randi_range(opponent.loot.hp, opponent.loot.hp_hi)
	var mp_increase := randi_range(opponent.loot.mp, opponent.loot.mp_hi)
	var atk_increase := randi_range(opponent.loot.atk, opponent.loot.atk_hi)
	var def_increase := randi_range(opponent.loot.def, opponent.loot.def_hi)
	var spd_increase := randi_range(opponent.loot.spd, opponent.loot.spd_hi)

	player.base_hp += hp_increase
	player.hp += hp_increase
	player.base_mp += mp_increase
	player.mp += mp_increase
	player.base_atk += atk_increase
	player.atk += atk_increase
	player.base_def += def_increase
	player.def += def_increase
	player.base_spd += spd_increase
	player.spd += spd_increase

	if hp_increase > 0:
		Console.print_line("* [%s] gained [%d] HP" % [player, hp_increase])

	if mp_increase > 0:
		Console.print_line("* [%s] gained [%d] MP" % [player, mp_increase])

	if atk_increase > 0:
		Console.print_line("* [%s] gained [%d] ATK" % [player, atk_increase])

	if def_increase > 0:
		Console.print_line("* [%s] gained [%d] DEF" % [player, def_increase])
	
	if spd_increase > 0:
		Console.print_line("* [%s] gained [%d] SPD" % [player, spd_increase])

	InputHandler.allow_inputs = true
