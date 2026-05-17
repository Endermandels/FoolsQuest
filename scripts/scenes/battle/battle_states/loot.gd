extends State

var valid_abilities: Array[AbilityRun] = []
var choosing_ability: bool = false
var selected_ability_idx: int = 0

func _print_ability_selection_prompt() -> void:
	Console.print_line("> Choose an Ability:", Color.ORANGE)
	for i in range(valid_abilities.size()):
		Console.print_line("%d. %s" % [i + 1, valid_abilities[i]], Color.ORANGE)
	Console.print_line("* Currently selecting [%s]" % valid_abilities[selected_ability_idx])

func step(data: BattleStateData) -> State:
	var state: State = null
	var player := data.get_player()

	# Select ability
	if choosing_ability:
		if InputHandler.inputs[InputHandler.InputType.CONFIRM]:
			InputHandler.clear_inputs()
			choosing_ability = false

			var ability: AbilityRun = valid_abilities[selected_ability_idx]

			if ability is SpecialRun:
				player.specials.append(ability)
			elif ability is PassiveRun:
				player.passives.append(ability)

			Console.print_line("* [%s] gained [%s]" % [player, ability])
		
		elif InputHandler.inputs[InputHandler.InputType.LEFT]:
			InputHandler.clear_inputs()
			selected_ability_idx = Helper.wrap(selected_ability_idx - 1, valid_abilities.size())
			Console.print_line("* Currently selecting [%s]" % valid_abilities[selected_ability_idx])
		
		elif InputHandler.inputs[InputHandler.InputType.RIGHT]:
			InputHandler.clear_inputs()
			selected_ability_idx = Helper.wrap(selected_ability_idx + 1, valid_abilities.size())
			Console.print_line("* Currently selecting [%s]" % valid_abilities[selected_ability_idx])

	# Transition to Location Scene
	else:
		InputHandler.allow_inputs = false

		var meta: LocationSetupRes = LocationSetupRes.new()
		meta.player = data.get_player()
		get_tree().set_meta(LocationSetupRes.meta_id, meta)
		get_tree().change_scene_to_file(ResourceHandler.location_scene)

	return state

func _is_valid_ability(a: AbilityRun, player: UnitRun) -> bool:
	return (not player.passives.any(func (x): return x.name_id == a.name_id)) and (not player.specials.any(func (x): return x.name_id == a.name_id))

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

	# Get Valid Abilities
	var valid_passives: Array[PassiveRun] = opponent.passives.filter(func (x): return _is_valid_ability(x, player))
	var valid_specials: Array[SpecialRun] = opponent.specials.filter(func (x): return _is_valid_ability(x, player))
	valid_abilities.append_array(valid_passives)
	valid_abilities.append_array(valid_specials)

	if valid_abilities.size() > 0:
		InputHandler.allow_inputs = true
		choosing_ability = true
		valid_abilities.assign(Helper.random_subset(valid_abilities, 2))
		_print_ability_selection_prompt()
