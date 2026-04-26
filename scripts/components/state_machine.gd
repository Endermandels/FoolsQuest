extends Node
class_name StateMachine

@export var cur_state: State ## Must be initialized to the starting state
var _data: StateData ## Data that can be modified by the states (optional)

func init(data: StateData) -> void:
	_data = data
	cur_state.enter(_data)

func step() -> void:
	var new_state = cur_state.step(_data)
	
	if new_state:
		cur_state.exit(_data)
		new_state.enter(_data)
		cur_state = new_state
