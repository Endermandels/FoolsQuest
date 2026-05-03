extends EffectRun
class_name AllRun

var effects: Array[EffectRes]

func init(res: AllRes) -> void:
	self.effects = res.effects.duplicate_deep()

func _apply(source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false
	
	assert(effects.size() > 0)

	for e_res: EffectRes in effects:
		var temp: bool = false
		var e_run: EffectRun = EffectRun.from_resource(e_res)

		temp = e_run.apply(source, target)
		res = res or temp

		# Break early for death
		if not source.is_alive or not target.is_alive:
			break

	return res
