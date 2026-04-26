extends Node
class_name BattleHandler

@export var state_machine: BattleStateMachine

var data: BattleStateData

func _ready() -> void:
	data = BattleStateData.new()
	state_machine.init(data)

func left() -> void:
	data.is_attack_action = not data.is_attack_action
	step()

func right() -> void:
	left()

func confirm() -> void:
	data.player_confirm = true
	step()

func step() -> void:
	state_machine.step()
