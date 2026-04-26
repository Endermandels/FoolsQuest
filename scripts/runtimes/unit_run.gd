extends RefCounted
class_name UnitRun

# Base Stats
var base_hp: int
var base_mp: int
var base_atk: int
var base_def: int
var base_spd: int

# Variable Stats
var hp: int
var mp: int
var atk: int
var def: int
var spd: int

# Status Effects
var is_poisoned: bool = false
var is_burning: bool = false
var is_bleeding: bool = false
var is_stunned: bool = false
var is_blind: bool = false

var burn_turns_left: int = 0
var bleed_turns_left: int = 0
var chance_to_miss_attack: float = 0.0

func _init(res: UnitRes) -> void:
	# Base Stats
	base_hp = res.base_hp
	base_mp = res.base_mp
	base_atk = res.base_atk
	base_def = res.base_def
	base_spd = res.base_spd

	# Variable Stats
	hp = base_hp
	mp = base_mp
	atk = base_atk
	def = base_def
	spd = base_spd
