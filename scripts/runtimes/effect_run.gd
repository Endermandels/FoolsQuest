extends RefCounted
class_name EffectRun

var targeting: Enums.EffectTargeting
var near_death_only: bool
var always_accurate: bool
var accuracy_percent: int:
	set(val):
		accuracy_percent = clampi(val, 0, 100)

static func from_resource(res: EffectRes) -> EffectRun:
	if res is DMGRes:
		return DMGRun.new(res)
	elif res is BleedRes:
		return BleedRun.new(res)
	elif res is PoisonRes:
		return PoisonRun.new(res)
	elif res is BurnRes:
		return BurnRun.new(res)
	elif res is HealRes:
		return HealRun.new(res)
	elif res is BlindRes:
		return BlindRun.new(res)
	elif res is ResistanceRes:
		return ResistanceRun.new(res)
	elif res is BloodLustRes:
		return BloodLustRun.new(res)
	elif res is CleanseRes:
		return CleanseRun.new(res)
	push_error("Unknown EffectRes")
	return EffectRun.new(res)

func _init(res: EffectRes) -> void:
	self.targeting = res.targeting
	self.near_death_only = res.source_near_death_only
	self.always_accurate = res.always_accurate
	self.accuracy_percent = res.accuracy_percent
	init(res)

## Implemented by subclass. Called on _init.
func init(_res) -> void:
	pass

## Apply an effect given the [source] of the effect and [source]'s [opponent] using the preestablished targeting rule.
## Returns whether the effect was successful.
func apply(source: UnitRun, opponent: UnitRun = null) -> bool:
	var res: bool = false
	var near_death: bool = source != null and source.is_near_death
	var accuracy_succeeded: bool = (always_accurate or Helper.rnd_succeeded(accuracy_percent)) and (not near_death_only or near_death)

	if accuracy_succeeded:
		if targeting == Enums.EffectTargeting.SELF:
			res = _apply(source, source)
		elif targeting == Enums.EffectTargeting.OPPONENT:
			res = _apply(source, opponent)
		else:
			push_error("Unknown targeting rule: %s" % targeting)

	return res	

## Implemented by subclass.
## Returns whether the effect was successful.
func _apply(_source: UnitRun, _target: UnitRun) -> bool:
	return false
