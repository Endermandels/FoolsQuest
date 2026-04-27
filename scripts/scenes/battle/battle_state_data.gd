extends StateData
class_name BattleStateData

#region Preloads
const status_effects_res: StatusEffectsRes = preload("res://resources/status_effects.tres")
#endregion

#region Variables
var units: Array[UnitRun] = []
var turn_idx: int = 0
var input_data: BattleInputData
#endregion

#region Functions
func _init(input_data: BattleInputData) -> void:
	self.input_data = input_data

func next_unit() -> void:
	turn_idx += 1
	if turn_idx >= units.size():
		turn_idx = 0

func has_death_occurred() -> bool:
	return units.any(func (x: UnitRun): return not x.is_alive)
#endregion
