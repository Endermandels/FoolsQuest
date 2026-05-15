extends State

var selected_location_idx: int = 0

func _print_location_prompt() -> void:
	Console.print_line("> Choose a Location:", Color.ORANGE)
	for i in range(ResourceHandler.location_resources.size()):
		Console.print_line("%d. %s" % [i + 1, ResourceHandler.location_resources[i]], Color.ORANGE)
	Console.print_line("* Currently selecting [%s]" % ResourceHandler.location_resources[selected_location_idx])

func step(data: LocationStateData) -> State:
	var state: State = null

	if InputHandler.inputs[InputHandler.InputType.CONFIRM]:
		InputHandler.clear_inputs()
		InputHandler.allow_inputs = false
		
		var opponent_res = LocationRun.new(ResourceHandler.location_resources[selected_location_idx]).get_animal()
		var meta: BattleSetupRes = BattleSetupRes.new()

		meta.player = data.player
		meta.opponent = UnitRun.new(opponent_res, false, ResourceHandler.ai_resources.pick_random())
		
		get_tree().set_meta(BattleSetupRes.meta_id, meta)
		get_tree().change_scene_to_file(ResourceHandler.battle_scene)
	elif InputHandler.inputs[InputHandler.InputType.LEFT]:
		InputHandler.clear_inputs()
		selected_location_idx = Helper.wrap(selected_location_idx - 1, ResourceHandler.location_resources.size())
		Console.print_line("* Currently selecting [%s]" % ResourceHandler.location_resources[selected_location_idx])
	elif InputHandler.inputs[InputHandler.InputType.RIGHT]:
		InputHandler.clear_inputs()
		selected_location_idx = Helper.wrap(selected_location_idx + 1, ResourceHandler.location_resources.size())
		Console.print_line("* Currently selecting [%s]" % ResourceHandler.location_resources[selected_location_idx])

	return state

func enter(data: LocationStateData) -> void:
	Console.print_line("# Location Selection #", Color.GREEN)
	
	var meta: LocationSetupRes = get_tree().get_meta("location_data")

	assert(meta != null and meta.player != null)
	
	data.player = meta.player
	
	get_tree().remove_meta(LocationSetupRes.meta_id)
	_print_location_prompt()

	InputHandler.allow_inputs = true
