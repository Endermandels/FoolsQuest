extends RefCounted
class_name UnitRun

var name_id: String
var is_player: bool = false
var is_alive: bool = false
var is_near_death: bool = false
var first_turn_action: bool = true
var attack_is_pure: bool = false

# NPC specific
var ai: AIRes
var loot: LootRes

# Abilities
var passives: Array[PassiveRun]
var temp_passives: Array[PassiveRun]
var specials: Array[SpecialRun]

# Base Stats
var base_hp: int
var base_mp: int
var base_atk: int
var base_def: int
var base_spd: int

# Variable Stats
var hp: int:
	set(val):
		hp = clampi(val, 0, base_hp)
		is_alive = hp > 0
		is_near_death = (float(hp) / float(base_hp)) <= (1.0 / 3.0) # Near death at 1/3 Base HP
var mp: int:
	set(val):
		mp = clampi(val, 0, base_mp)
var atk: int:
	set(val):
		atk = max(val, 1) # Allow ATK to exceed Base ATK, ATK should never drop below 1
var def: int:
	set(val):
		def = max(val, 0) # Allow DEF to exceed Base DEF
var spd: int:
	set(val):
		spd = max(val, 0) # Allow SPD to exceed Base SPD

# Status Effects
var is_poisoned: bool = false
var is_burning: bool = false
var is_bleeding: bool = false
var is_stunned: bool = false
var is_blind: bool = false

var burn_turns_left: int = 0:
	set(val):
		burn_turns_left = max(val, 0)
		is_burning = burn_turns_left > 0
var bleed_turns_left: int = 0:
	set(val):
		bleed_turns_left = max(val, 0)
		is_bleeding = bleed_turns_left > 0
var blind_turns_left: int = 0:
	set(val):
		blind_turns_left = max(val, 0)
		is_blind = blind_turns_left > 0

# Immunities
var resists_poison: bool = false
var resists_burn: bool = false
var resists_bleed: bool = false
var resists_stun: bool = false
var resists_blindness: bool = false

var poison_resistance_turns_left: int = 0:
	set(val):
		poison_resistance_turns_left = max(val, 0)
		resists_poison = poison_resistance_turns_left > 0
var burn_resistance_turns_left: int = 0:
	set(val):
		burn_resistance_turns_left = max(val, 0)
		resists_burn = burn_resistance_turns_left > 0
var bleed_resistance_turns_left: int = 0:
	set(val):
		bleed_resistance_turns_left = max(val, 0)
		resists_bleed = bleed_resistance_turns_left > 0
var stun_resistance_turns_left: int = 0:
	set(val):
		stun_resistance_turns_left = max(val, 0)
		resists_stun = stun_resistance_turns_left > 0
var blindness_resistance_turns_left: int = 0:
	set(val):
		blindness_resistance_turns_left = max(val, 0)
		resists_blindness = blindness_resistance_turns_left > 0

func _init(res: UnitRes, is_player: bool = false, ai: AIRes = null) -> void:
	self.name_id = res.name_id
	self.is_player = is_player

	# NPC specific
	if not is_player:
		self.ai = ai
		self.loot = res.loot
		assert(self.loot != null)
		assert(self.ai != null)

	# Base Stats
	self.base_hp = res.base_hp
	self.base_mp = res.base_mp
	self.base_atk = res.base_atk
	self.base_def = res.base_def
	self.base_spd = res.base_spd

	# Variable Stats
	self.hp = base_hp
	self.mp = base_mp
	self.atk = base_atk
	self.def = base_def
	self.spd = base_spd

	# Abilities
	for p_res: PassiveRes in res.passives:
		var p_run: PassiveRun = PassiveRun.new(p_res)
		self.passives.append(p_run)

	for s_res: SpecialRes in res.specials:
		var s_run: SpecialRun = SpecialRun.new(s_res)
		self.specials.append(s_run)

func _to_string() -> String:
	return name_id
