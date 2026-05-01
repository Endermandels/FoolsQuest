extends Node
class_name State

## Returns the new State to transition to or null. Passed StateData [data]
func step(_data) -> State:
	# TODO: Implement
	return null

## Called upon transitioning to this state. Passed StateData [data]
func enter(_data) -> void:
	# TODO: Implement
	pass

## Called upon transitioning from this state. Passed StateData [data]
func exit(_data) -> void:
	# TODO: Implement
	pass
