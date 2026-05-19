extends State

@export var turn_start_first: State
@export var battle_end: State

func _increase_stats(unit: UnitRun) -> void:
	var hp_increase: int = randi_range(unit.loot.hp, unit.loot.hp_hi)
	var mp_increase: int = randi_range(unit.loot.mp, unit.loot.mp_hi)
	var atk_increase: int = randi_range(unit.loot.atk, unit.loot.atk_hi)
	var def_increase: int = randi_range(unit.loot.def, unit.loot.def_hi)
	var spd_increase: int = randi_range(unit.loot.spd, unit.loot.spd_hi)

	unit.base_hp += hp_increase
	unit.hp += hp_increase
	unit.base_mp += mp_increase
	unit.mp += mp_increase
	unit.base_atk += atk_increase
	unit.atk += atk_increase
	unit.base_def += def_increase
	unit.def += def_increase
	unit.base_spd += spd_increase
	unit.spd += spd_increase

func step(data: BattleStateData) -> State:
	var state = turn_start_first
	
	print("* Step Battle Start")
	
	var player: UnitRun
	var opponent: UnitRun

	if not get_tree().has_meta(BattleSetupRes.meta_id):
		# Initialize Tutorial Battle
		player = UnitRun.new(ResourceHandler.player, true)
		opponent = UnitRun.new(ResourceHandler.squirrel, false, ResourceHandler.ai_resources.pick_random())
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

	# Dragon initial phase
	if opponent is DragonRun:
		Console.print_line("! [%s] %s" % [opponent, opponent.phases[opponent.phase + 1].phase_enter_description], Color.MAGENTA)
		opponent.new_phase(data.get_player())

	# Increase opponent's stats
	for i in range(ResourceHandler.battle_logic_res.n_battles_to_scale, MetaData.battles_fought, ResourceHandler.battle_logic_res.n_battles_to_scale):
		# Increase twice to compensate for missing out on three battles
		_increase_stats(opponent)
		_increase_stats(opponent)
	
	data.units.sort_custom(func (x: UnitRun, y: UnitRun): return x.spd > y.spd) # Sort by SPD

	Console.print_line("* [%s] encountered a%s [%s] [%s]" % 
		[player, "n" if opponent.ai.name_id[0].to_lower() in Constants.VOWELS else "", opponent.ai, opponent])

	for i in range(data.units.size()):
		if data.trigger_passives(data.units[i], null, Constants.PassiveType.BATTLE_START_SELF):
			state = battle_end
			break

	return state

func enter(_data: BattleStateData) -> void:
	Console.print_line("# Battle Start #", Color.GREEN)
