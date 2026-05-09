extends State

# TODO: Get initialized units from Location Selection choice
#region # TODO: DELETE
const PLAYER = preload("res://resources/units/player.tres")
const WOLF = preload("res://resources/units/wolf.tres")
const SNAKE = preload("res://resources/units/snake.tres")
const DRAGON = preload("res://resources/units/dragon.tres")
const BEAR = preload("res://resources/units/bear.tres")
const TURTLE = preload("res://resources/units/turtle.tres")
const FALCON = preload("res://resources/units/falcon.tres")
const PORCUPINE = preload("res://resources/units/porcupine.tres")
const DEER = preload("res://resources/units/deer.tres")
#endregion

const VOWELS = ["a", "e", "i", "o", "u"]

@export var turn_start_first: State
@export var battle_end: State

func step(data: BattleStateData) -> State:
	var state = turn_start_first
	
	print("* Step Battle Start")

	#region # TODO: CHANGE
	var player: UnitRun = UnitRun.new(PLAYER.duplicate_deep(), true)
	var enemy: UnitRun = UnitRun.new(DEER.duplicate_deep())
	data.units.append(player)
	data.units.append(enemy)
	#endregion
	
	data.units.sort_custom(func (x: UnitRun, y: UnitRun): return x.spd > y.spd) # Sort by SPD

	Console.print_line("* [%s] encountered a%s [%s] [%s]" % [player, "n" if enemy.ai.name_id[0].to_lower() in VOWELS else "", enemy.ai, enemy])

	for i in range(data.units.size()):
		if data.trigger_passives(data.units[i], null, Enums.PassiveType.BATTLE_START_SELF):
			state = battle_end
			break

	return state

func enter(_data: BattleStateData) -> void:
	Console.print_line("# Battle Start #", Color.GREEN)
