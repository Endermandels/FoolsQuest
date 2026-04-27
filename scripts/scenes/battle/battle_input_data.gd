extends RefCounted
class_name BattleInputData

enum InputType {
	LEFT	= 0,
	RIGHT	= 1,
	CONFIRM	= 2,
	BACK	= 3,
}

## Determines whether new inputs are allowed in the current game state
var allow_inputs: bool = false

# Previous input state
var inputs: Array[bool] = [false, false, false, false] ## Index using InputType

func clear_inputs() -> void:
	for i in range(inputs.size()):
		inputs[i] = false
