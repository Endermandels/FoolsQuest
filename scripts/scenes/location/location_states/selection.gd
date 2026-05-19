extends State

var locations: Array[LocationRes]
var selected_location_idx: int = 0

func _print_location_prompt() -> void:
	Console.print_line("> Choose a Location:", Color.ORANGE)
	for i in range(locations.size()):
		Console.print_line("%d. %s" % [i + 1, locations[i]], Color.ORANGE)
	Console.print_line("* Currently selecting [%s]" % locations[selected_location_idx])

func _pick_random_animal(animals: Array[AnimalRes]) -> UnitRes:
	var res: UnitRes = null
	var total_weight: int = 0
	var cum_weight: int = 0
	var rnd: int

	for a: AnimalRes in animals:
		total_weight += a.weight
	
	assert(total_weight > 0)

	rnd = randi_range(1, total_weight)

	for a: AnimalRes in animals:
		cum_weight += a.weight
		if rnd <= cum_weight:
			res = a.res
			break

	return res

func step(data: LocationStateData) -> State:
	var state: State = null

	if InputHandler.inputs[InputHandler.InputType.CONFIRM]:
		InputHandler.clear_inputs()
		InputHandler.allow_inputs = false
		
		var location_res := locations[selected_location_idx]
		var opponent_res := _pick_random_animal(location_res.animals)
		var meta: BattleSetupRes = BattleSetupRes.new()

		meta.player = data.player
		if opponent_res is DragonRes:
			meta.opponent = DragonRun.new(opponent_res) 
		else:
			meta.opponent = UnitRun.new(opponent_res, false, ResourceHandler.ai_resources.pick_random())
		
		get_tree().set_meta(BattleSetupRes.meta_id, meta)
		get_tree().change_scene_to_file(ResourceHandler.battle_scene)
	elif InputHandler.inputs[InputHandler.InputType.LEFT]:
		InputHandler.clear_inputs()
		selected_location_idx = Helper.wrap(selected_location_idx - 1, locations.size())
		Console.print_line("* Currently selecting [%s]" % locations[selected_location_idx])
	elif InputHandler.inputs[InputHandler.InputType.RIGHT]:
		InputHandler.clear_inputs()
		selected_location_idx = Helper.wrap(selected_location_idx + 1, locations.size())
		Console.print_line("* Currently selecting [%s]" % locations[selected_location_idx])

	return state

func enter(data: LocationStateData) -> void:
	Console.print_line("# Location Selection #", Color.GREEN)
	
	var meta: LocationSetupRes = get_tree().get_meta("location_data")

	assert(meta != null and meta.player != null)
	
	data.player = meta.player
	
	get_tree().remove_meta(LocationSetupRes.meta_id)

	if MetaData.battles_fought >= ResourceHandler.battle_logic_res.n_battles_to_dragon:
		locations = [ResourceHandler.dragon_location]
	else:
		locations = ResourceHandler.location_resources

	_print_location_prompt()

	InputHandler.allow_inputs = true
