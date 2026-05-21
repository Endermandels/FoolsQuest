extends Node2D
class_name Victory

const COMMANDS = {
	"quit": ["quit", "exit"],
	"clear": ["clear"]
}

func _ready() -> void:
	Console.print_line("$$$ Victory $$$", Color.GOLD)

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
