extends Resource
class_name DragonPhaseRes

@export_range(0, 100) var hp_percent_trigger = 100 ## Percent HP needs to reach to trigger this phase
@export var phase_enter_description: String = ""
@export var ais: Array[AIRes] = []
@export var specials: Array[SpecialRes] = []
@export var passives: Array[PassiveRes] = []
@export var transition_effects: Array[EffectRes] = [] ## Should be empty for the first phase
