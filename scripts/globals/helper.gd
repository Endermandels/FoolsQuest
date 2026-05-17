extends Node
# Global

## Returns whether the random chance succeeded
func rnd_succeeded(chance_percent: int) -> bool:
	assert(0 <= chance_percent and chance_percent <= 100)
	return (chance_percent > 0) and (randf() <= (float(chance_percent) / 100.0))

## Returns [idx] within [lower_bound] (inclusive) to [upper_bound] (exclusive), wrapping around if out of bounds
func wrap(idx: int, upper_bound: int, lower_bound: int = 0) -> int:
	var res: int = idx

	if res < lower_bound:
		res = upper_bound - 1
	elif res >= upper_bound:
		res = lower_bound

	return res

## Returns a subset of [n] random elements from [arr].
## [n] is capped at the size of [arr].
func random_subset(arr: Array, n: int) -> Array:
	var res: Array = []

	arr = arr.duplicate() # Avoid altering the original array

	n = min(n, arr.size())

	for i in range(n):
		var element = arr.pick_random()

		res.append(element)
		arr.erase(element)

	return res