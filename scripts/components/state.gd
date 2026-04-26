extends Node
class_name State

## Returns the new State to transition to or null. Passed StateData [data]
func step(data) -> State:
	# TODO: Implement
	return null

## Called upon transitioning to this state. Passed StateData [data]
func enter(data) -> void:
	# TODO: Implement
	pass

## Called upon transitioning from this state. Passed StateData [data]
func exit(data) -> void:
	# TODO: Implement
	pass
