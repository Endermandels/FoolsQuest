extends Node
class_name LocationHandler

@export var state_machine: StateMachine

func _ready() -> void:
	state_machine.init(LocationStateData.new())

func input_signal(type: Inputs.InputType) -> void:
	if Inputs.allow_inputs:
		Inputs.inputs[type] = true
	state_machine.step()
