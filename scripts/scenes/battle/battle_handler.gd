extends Node
class_name BattleHandler

@export var battle_state_machine: StateMachine
@export var auto_step_timer: Timer

func _ready() -> void:
	battle_state_machine.init(BattleStateData.new())
	auto_step_timer.timeout.connect(step)

func input_signal(type: Inputs.InputType) -> void:
	if Inputs.allow_inputs:
		Inputs.inputs[type] = true
	step()

func step() -> void:
	battle_state_machine.step()

## If wait_time is specified, start the auto_step_timer at the specified wait_time.  Otherwise, toggle auto_step_timer.
func auto(wait_time: float = 0) -> void:
	if wait_time > 0 and wait_time != auto_step_timer.wait_time:
		auto_step_timer.wait_time = wait_time
		if auto_step_timer.is_stopped():
			auto_step_timer.start()
	else:
		if auto_step_timer.is_stopped():
			auto_step_timer.start()
		else:
			auto_step_timer.stop()
