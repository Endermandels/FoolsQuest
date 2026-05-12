extends State

func step(data: LocationStateData) -> State:
	var state: State = null
	
	return state

func enter(data: LocationStateData) -> void:
	Console.print_line("# Location Selection #", Color.GREEN)
	
	var meta = get_tree().get_meta("location_data")

	assert(meta != null)

