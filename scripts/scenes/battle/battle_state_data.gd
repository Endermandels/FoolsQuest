extends StateData
class_name BattleStateData

#region Variables
var battle_logic_res: BattleLogicRes
var units: Array[UnitRun] = []
var turns: int = 0
var turn_idx: int = 0
var selected_special_idx: int = 0
#endregion

#region Functions
func _init(battle_logic_res: BattleLogicRes):
	self.battle_logic_res = battle_logic_res

func next_turn() -> void:
	turns += 1
	turn_idx += 1
	if turn_idx >= units.size():
		turn_idx = 0

func has_death_occurred() -> bool:
	return units.any(func(x: UnitRun): return not x.is_alive)

## Returns whether the passive had any effect.
func trigger_passives(source: UnitRun, opponent: UnitRun, ptype: Constants.PassiveType) -> bool:
	var successful: bool = false
	var all_passives: Array[PassiveRun] = source.passives + source.temp_passives

	for p: PassiveRun in all_passives:
		if p.type == ptype:
			for e_res: EffectRes in p.effects:
				var e_run = EffectRun.from_resource(e_res)
				var temp := false

				if (ptype == Constants.PassiveType.PRE_ATTACK or
						ptype == Constants.PassiveType.POST_ATTACK or
						ptype == Constants.PassiveType.PRE_DEFENSE or
						ptype == Constants.PassiveType.POST_DEFENSE):
					temp = e_run.apply(source, opponent)
				elif (ptype == Constants.PassiveType.TURN_START_SELF or
						ptype == Constants.PassiveType.BATTLE_START_SELF):
					temp = e_run.apply(source, source)
				else:
					push_error("! Unknown passive type: '%s'" % ptype)

				successful = successful or temp or e_run is DMGRun # DMGRun always inflicts damage but only reports success if it damages over the DEF threshold

	return successful
	
func get_opponent() -> UnitRun:
	var res: UnitRun = null

	for u in units:
		if not u.is_player:
			res = u

	return res
#endregion
