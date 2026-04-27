extends State

# TODO: Get initialized units from Location Selection choice
#region # TODO: DELETE
const PLAYER = preload("res://resources/units/player.tres")
const WOLF = preload("res://resources/units/wolf.tres")
const SNAKE = preload("res://resources/units/snake.tres")
#endregion

@export var turn_start_burn: State

func step(data: BattleStateData) -> State:
	print("* Step Battle Start")
	#region # TODO: CHANGE
	var player: UnitRun = UnitRun.new(PLAYER.duplicate(), true)
	var enemy: UnitRun = UnitRun.new(SNAKE.duplicate())
	data.units.append(player)
	data.units.append(enemy)
	#endregion
	data.units.sort_custom(func (x: UnitRun, y: UnitRun): return x.spd > y.spd) # Sort by SPD
	print("* Initialized units")
	return turn_start_burn

func enter(_data: BattleStateData) -> void:
	Console.print_line("# Battle Start #", Color.GREEN)
