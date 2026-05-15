extends Node2D
class_name Location

const COMMANDS = {
	"quit": ["quit", "exit"],
	"left": ["left", "l"],
	"right": ["right", "r"],
	"confirm": ["confirm", "c"],
	"back": ["back", "b"],
	"clear": ["clear"]
}

@export var location_handler: LocationHandler

func _process(_delta: float) -> void:
	var cmd_prms: PackedStringArray = []
	var curcmd: String = ""
	
	if Input.is_action_just_pressed("toggle_console"):
		Console.toggle()
	
	if Console.visible:
		cmd_prms = Console.get_command().strip_edges().to_lower().split(" ")
		curcmd = cmd_prms[0]

		if curcmd in COMMANDS.quit:
			get_tree().quit()
		elif curcmd in COMMANDS.clear:
			Console.clear()
		elif curcmd in COMMANDS.left:
			location_handler.input_signal(Inputs.InputType.LEFT)
		elif curcmd in COMMANDS.right:
			location_handler.input_signal(Inputs.InputType.RIGHT)
		elif curcmd in COMMANDS.confirm:
			location_handler.input_signal(Inputs.InputType.CONFIRM)
		elif curcmd in COMMANDS.back:
			location_handler.input_signal(Inputs.InputType.BACK)
