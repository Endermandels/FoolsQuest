extends State

@export var loot: State

var is_victory: bool = false

func step(_data: BattleStateData) -> State:
	var state: State = null

	# TODO: Transition to Defeat Scene on loss

	if is_victory:
		state = loot

	return state

func enter(data: BattleStateData) -> void:
	Console.print_line("# Battle End #", Color.GREEN)
	var player: UnitRun = data.get_player()

	# Reset ATK, DEF and SPD
	player.atk = player.base_atk
	player.def = player.base_def
	player.spd = player.base_spd

	# Reset Temporary Passives
	player.temp_passives.clear()

	# Reset Ability states
	for s: SpecialRun in player.specials:
		s.reset_state()

	# Report Win/Loss
	is_victory = player.is_alive
	if is_victory:
		Console.print_line("* Victory!")
	else:
		Console.print_line("* Defeat")
