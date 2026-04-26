extends RefCounted
class_name EffectRun

var targeting: Enums.EffectTargeting

static func from_resource(res: EffectRes) -> EffectRun:
	if res is DMGRes:
		return DMGRun.new(res)
	elif res is BleedRes:
		return BleedRun.new(res)
	elif res is PoisonRes:
		return PoisonRun.new(res)
	push_warning("Unknown EffectRes: %s" % res.get_class())
	return EffectRun.new(res)

func _init(res: EffectRes) -> void:
	self.targeting = res.targeting
	init(res)

## Implemented by subclass. Called on _init.
func init(res) -> void:
	pass

## Apply an effect given the [source] of the effect and [source]'s [opponent] using the preestablished targeting rule.
func apply(source: UnitRun, opponent: UnitRun = null) -> void:
	var targets: Array[UnitRun] = []
	if targeting == Enums.EffectTargeting.SELF:
		_apply(source, source)
	elif targeting == Enums.EffectTargeting.OPPONENT:
		_apply(source, opponent)
	elif targeting == Enums.EffectTargeting.BOTH:
		_apply(source, opponent)
		_apply(source, source)
	else:
		push_error("Unknown targeting rule: %s" % targeting)

## Implemented by subclass.
func _apply(source: UnitRun, target: UnitRun) -> void:
	pass
