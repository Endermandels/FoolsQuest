extends Node
class_name StateMachine

@export var cur_state: State ## Must be initialized to the starting state

var data: StateData = null ## Data that can be modified by the states (optional)

# ! Note: Use _init to initialize data, if desired

func _ready() -> void:
	cur_state.enter(data)

func step() -> void:
	var new_state = cur_state.step(data)
	
	if new_state:
		cur_state.exit(data)
		new_state.enter(data)
		cur_state = new_state
