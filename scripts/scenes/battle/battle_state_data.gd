extends StateData
class_name BattleStateData

#region Variables
var units: Array[UnitRun] = []
var turn_idx: int = 0
#endregion

#region Functions
func next_unit() -> void:
	turn_idx += 1
	if turn_idx >= units.size():
		turn_idx = 0
#endregion
