extends Node2D
class_name Battle

const COMMANDS = {
	"quit": ["quit", "exit"],
	"step": ["step", "s"],
	"left": ["left", "l"],
	"right": ["right", "r"],
	"confirm": ["confirm", "c"],
	"back": ["back", "b" ],
	"auto": ["auto", "a"],
	"clear": ["clear"]
}

@export var battle_handler: BattleHandler

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
		elif curcmd in COMMANDS.auto:
			if cmd_prms.size() > 1:
				battle_handler.auto(float(cmd_prms[1]))
			else:
				battle_handler.auto()
		elif curcmd in COMMANDS.step:
			battle_handler.step()
		elif curcmd in COMMANDS.left:
			battle_handler.input_signal(BattleInputData.InputType.LEFT)
		elif curcmd in COMMANDS.right:
			battle_handler.input_signal(BattleInputData.InputType.RIGHT)
		elif curcmd in COMMANDS.confirm:
			battle_handler.input_signal(BattleInputData.InputType.CONFIRM)
		elif curcmd in COMMANDS.back:
			battle_handler.input_signal(BattleInputData.InputType.BACK)
