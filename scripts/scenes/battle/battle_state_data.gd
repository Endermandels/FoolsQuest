extends StateData
class_name BattleStateData

#region Preloads
const status_effects_res: StatusEffectsRes = preload("res://resources/status_effects.tres")
#endregion

#region Variables
var units: Array[UnitRun] = []
var turns: int = 0
var turn_idx: int = 0
var selected_special_idx: int = 0
var input_data: BattleInputData
#endregion

#region Functions
func _init(input_data: BattleInputData) -> void:
	self.input_data = input_data

func next_turn() -> void:
	turns += 1
	turn_idx += 1
	if turn_idx >= units.size():
		turn_idx = 0

func has_death_occurred() -> bool:
	return units.any(func (x: UnitRun): return not x.is_alive)

## Returns whether a death has occurred.
func trigger_passives(cur_unit: UnitRun, opponent: UnitRun, ptype: Enums.PassiveType) -> bool:
	var has_death_occurred: bool = false
	var all_passives: Array[PassiveRes] = cur_unit.passives + cur_unit.temp_passives

	for p: PassiveRes in all_passives:
		if p.type == ptype:
			for e_res: EffectRes in p.effects:
				var e_run = EffectRun.from_resource(e_res)

				if ptype == Enums.PassiveType.PRE_ATTACK or ptype == Enums.PassiveType.POST_ATTACK:
					e_run.apply(cur_unit, opponent)
				elif ptype == Enums.PassiveType.PRE_DEFENSE or ptype == Enums.PassiveType.POST_DEFENSE:
					e_run.apply(opponent, cur_unit)
				elif ptype == Enums.PassiveType.TURN_START_SELF or ptype == Enums.PassiveType.BATTLE_START_SELF:
					e_run.apply(cur_unit, cur_unit)
				else:
					push_error("! Unknown passive type: '%s'" % ptype)

				if has_death_occurred():
					has_death_occurred = true
					break

	return has_death_occurred
#endregion
