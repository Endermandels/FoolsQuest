extends State

const LOCATIONS: Array[LocationRes] = [
	preload("res://resources/locations/locations/field.tres"),
]

@export_file_path("*.tscn") var battle_scene: String = ""

var selected_location_idx: int = 0

func _print_location_prompt() -> void:
	Console.print_line("> Choose a Location:", Color.ORANGE)
	for i in range(LOCATIONS.size()):
		Console.print_line("%d. %s" % [i + 1, LOCATIONS[i]], Color.ORANGE)
	Console.print_line("* Currently selecting [%s]" % LOCATIONS[selected_location_idx])

func step(data: LocationStateData) -> State:
	var state: State = null

	if Inputs.inputs[Inputs.InputType.CONFIRM]:
		Inputs.clear_inputs()
		Inputs.allow_inputs = false

		var meta: BattleSetupRes = BattleSetupRes.new()
		meta.player = data.player
		meta.opponent = LocationRun.new(LOCATIONS[selected_location_idx]).get_animal()
		
		get_tree().set_meta(BattleSetupRes.meta_id, meta)
		get_tree().change_scene_to_file(battle_scene)
	elif Inputs.inputs[Inputs.InputType.LEFT]:
		Inputs.clear_inputs()
		selected_location_idx = Helper.wrap(selected_location_idx - 1, LOCATIONS.size())
		Console.print_line("* Currently selecting [%s]" % LOCATIONS[selected_location_idx])
	elif Inputs.inputs[Inputs.InputType.RIGHT]:
		Inputs.clear_inputs()
		selected_location_idx = Helper.wrap(selected_location_idx + 1, LOCATIONS.size())
		Console.print_line("* Currently selecting [%s]" % LOCATIONS[selected_location_idx])

	return state

func enter(data: LocationStateData) -> void:
	Console.print_line("# Location Selection #", Color.GREEN)
	
	var meta: LocationSetupRes = get_tree().get_meta("location_data")

	assert(meta != null and meta.player != null)
	
	data.player = meta.player
	
	get_tree().remove_meta(LocationSetupRes.meta_id)
	_print_location_prompt()

	Inputs.allow_inputs = true
