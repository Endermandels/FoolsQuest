extends Node2D
class_name Battle

const COMMANDS = {
	"quit": ["quit", "exit"],
	"step": ["step", "s"]
}

@export var state_machine: BattleStateMachine

func _process(_delta: float) -> void:
	var curcmd: String = ""
	
	if Input.is_action_just_pressed("toggle_console"):
		Console.toggle()
	
	if Console.visible:
		curcmd = Console.get_command().to_lower()

		if curcmd in COMMANDS.quit:
			get_tree().quit()
		elif curcmd in COMMANDS.step:
			state_machine.step()
