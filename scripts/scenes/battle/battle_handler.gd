extends Node
class_name BattleHandler

@export var battle_state_machine: StateMachine

var input_data: BattleInputData

func _ready() -> void:
	input_data = BattleInputData.new()
	battle_state_machine.data = BattleStateData.new(input_data)

func input_signal(type: BattleInputData.InputType) -> void:
	if input_data.allow_inputs:
		input_data.inputs[type] = true
	step()

func step() -> void:
	battle_state_machine.step()
