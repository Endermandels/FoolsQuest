extends Node
# Global

func rnd_succeeded(chance_percent: int) -> bool:
	assert(0 <= chance_percent and chance_percent <= 100)
	return randf() <= (float(chance_percent) / 100.0)
