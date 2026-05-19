extends UnitRun
class_name DragonRun

var phase: int = -1
var phases: Array[DragonPhaseRes]

func _init(res: DragonRes, is_player: bool = false, _ai: AIRes = null) -> void:
	self.phases = res.phases.duplicate_deep()

	super._init(res, is_player, self.phases[0].ais.pick_random())

func new_phase(player: UnitRun) -> void:
	phase += 1
	var cur_phase: DragonPhaseRes = phases[phase]

	# AI
	ai = cur_phase.ais.pick_random()

	# Abilities
	passives.clear()
	specials.clear()

	for p_res: PassiveRes in cur_phase.passives:
		var p_run: PassiveRun = PassiveRun.new(p_res)
		passives.append(p_run)

	for s_res: SpecialRes in cur_phase.specials:
		var s_run: SpecialRun = SpecialRun.new(s_res)
		specials.append(s_run)

	# Transition Effects
	for e_res: EffectRes in cur_phase.transition_effects:
		var e_run: EffectRun = EffectRun.new(e_res)
		e_run.apply(self, player)
