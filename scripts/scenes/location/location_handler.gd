extends Node
class_name LocationHandler

@export var state_machine: StateMachine

func _ready() -> void:
	state_machine.init(LocationStateData.new())

func input_signal(type: InputHandler.InputType) -> void:
	if InputHandler.allow_inputs:
		InputHandler.inputs[type] = true
	state_machine.step()
