extends RefCounted
class_name EffectRun

static func from_resource(res: EffectRes) -> EffectRun:
	if res is DMGRes:
		return DMGRun.new(res)
	push_warning("Unknown EffectRes: %s" % res.get_class())
	return EffectRun.new(res)

func _init(res: EffectRes) -> void:
	init(res)

## For subclasses. Called on _init.
func init(res) -> void:
	pass

## Apply an effect given the [source] and [target] of the effect.
func apply(source: UnitRun, target: UnitRun) -> void:
	pass