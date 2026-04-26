extends State

# TODO: Get initialized units from Location Selection choice
#region # TODO: DELETE
const PLAYER = preload("res://resources/units/player.tres")
const WOLF = preload("res://resources/units/wolf.tres")
#endregion

@export var turn_start_burn: State

func step(data: BattleStateData) -> State:
	#region # TODO: CHANGE
	var player: UnitRun = UnitRun.new(PLAYER.duplicate(), true)
	var enemy: UnitRun = UnitRun.new(WOLF.duplicate())
	data.units.append(player)
	data.units.append(enemy)
	print("* Initialized units")
	#endregion
	return turn_start_burn

func enter(_data: BattleStateData) -> void:
	Console.print_line("# Battle Start #", Color.GREEN)
