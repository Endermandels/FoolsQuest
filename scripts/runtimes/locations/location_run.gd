extends RefCounted
class_name LocationRun

var name_id: String
var description: String # TODO: Make use of this variable
var animal_groups: Array[AnimalGroupRes]

func _init(res: LocationRes) -> void:
	self.name_id = res.name_id
	self.description = res.description
	self.animal_groups = res.animal_groups

func _pick_random_animal(group: AnimalGroupRes) -> UnitRes:
	var res: UnitRes = null
	var total_weight: int = 0
	var cum_weight: int = 0
	var rnd: int

	for a: AnimalRes in group.animals:
		total_weight += a.weight
	
	assert(total_weight > 0)

	rnd = randi_range(1, total_weight)

	for a: AnimalRes in group.animals:
		cum_weight += a.weight
		if rnd <= cum_weight:
			res = a.res
			break

	return res

func get_animal() -> UnitRes:
	var res: UnitRes = null

	# Choose a random animal group
	var group: AnimalGroupRes = animal_groups.pick_random()

	# Choose a weighted random animal from the group
	res = _pick_random_animal(group)

	return res