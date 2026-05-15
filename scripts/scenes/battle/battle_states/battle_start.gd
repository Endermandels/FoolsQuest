extends State

# Tutorial battle
const PLAYER = preload("res://resources/units/units/player.tres")
const SQUIRREL = preload("res://resources/units/units/squirrel.tres")

const VOWELS = ["a", "e", "i", "o", "u"]

@export var turn_start_first: State
@export var battle_end: State

func step(data: BattleStateData) -> State:
	var state = turn_start_first
	
	print("* Step Battle Start")
	
	var player: UnitRun
	var opponent: UnitRun

	if not get_tree().has_meta(BattleSetupRes.meta_id):
		# Initialize Tutorial Battle
		player = UnitRun.new(PLAYER.duplicate_deep(), true)
		opponent = UnitRun.new(SQUIRREL.duplicate_deep())
		data.units.append(player)
		data.units.append(opponent)
	else:
		# Initialize Location units
		var meta: BattleSetupRes = get_tree().get_meta(BattleSetupRes.meta_id)
		player = meta.player
		opponent = meta.opponent
		data.units.append(meta.player)
		data.units.append(meta.opponent)
		get_tree().remove_meta(BattleSetupRes.meta_id)
	
	data.units.sort_custom(func (x: UnitRun, y: UnitRun): return x.spd > y.spd) # Sort by SPD

	Console.print_line("* [%s] encountered a%s [%s] [%s]" % [player, "n" if opponent.ai.name_id[0].to_lower() in VOWELS else "", opponent.ai, opponent])

	for i in range(data.units.size()):
		if data.trigger_passives(data.units[i], null, Constants.PassiveType.BATTLE_START_SELF):
			state = battle_end
			break

	return state

func enter(_data: BattleStateData) -> void:
	Console.print_line("# Battle Start #", Color.GREEN)
