extends Node
class_name LocationHandler

@export var state_machine: StateMachine

func _ready() -> void:
	state_machine.init(LocationStateData.new())

func input_signal(type: InputHandler.InputType) -> void:
	if InputHandler.allow_inputs:
		InputHandler.inputs[type] = true
	state_machine.step()

func stats() -> void:
	var player: UnitRun = state_machine.data.player
	Console.print_line("* [%s] (HP %d|MP %d|ATK %d|DEF %d|SPD %d)" % 
		[player, player.hp, player.mp, player.atk, player.def, player.spd])
