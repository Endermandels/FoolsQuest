extends State

# TODO: Get initialized units from Location Selection choice
#region # TODO: DELETE
const PLAYER = preload("res://resources/units/player.tres")
const WOLF = preload("res://resources/units/wolf.tres")
const SNAKE = preload("res://resources/units/snake.tres")
#endregion

const VOWELS = ["a", "e", "i", "o", "u"]

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
	Console.print_line("* [%s] encountered a%s [%s] [%s]" % [player, "n" if enemy.ai.name_id[0].to_lower() in VOWELS else "", enemy.ai, enemy])
	return turn_start_burn

func enter(_data: BattleStateData) -> void:
	Console.print_line("# Battle Start #", Color.GREEN)
