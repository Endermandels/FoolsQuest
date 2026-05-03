extends EffectRun
class_name RandomRun

var effects: Array[EffectRes]

func init(res: RandomRes) -> void:
	self.effects = res.effects.duplicate_deep()

func _apply(source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false
	
	assert(effects.size() > 0)

	var e_run: EffectRun = EffectRun.from_resource(effects.pick_random())

	res = e_run.apply(source, target)

	return res
