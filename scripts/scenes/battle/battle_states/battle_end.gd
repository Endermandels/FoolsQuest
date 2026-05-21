extends State

@export var loot: State

var is_victory: bool = false

func step(_data: BattleStateData) -> State:
	var state: State = null

	# TODO: Transition to Defeat Scene on loss

	if is_victory:
		MetaData.battles_fought += 1
		state = loot

	return state

func enter(_data: BattleStateData) -> void:
	Console.print_line("# Battle End #", Color.LIME_GREEN)
	var player: UnitRun = MetaData.player

	# Reset Player
	player.atk = player.base_atk
	player.def = player.base_def
	player.spd = player.base_spd
	player.temp_passives.clear()
	player.reset_state()
	for s: SpecialRun in player.specials:
		s.reset_state()

	# Report Win/Loss
	is_victory = player.is_alive
	if is_victory:
		Console.print_line("* Victory!")
	else:
		Console.print_line("* Defeat")
