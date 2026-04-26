extends RefCounted
class_name UnitRun

var name_id: String
var is_player: bool = false
var is_alive: bool = false

# Base Stats
var base_hp: int
var base_mp: int
var base_atk: int
var base_def: int
var base_spd: int

# Variable Stats
var hp: int:
	set(val):
		hp = max(0, val)
		is_alive = hp > 0
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

func _init(res: UnitRes, is_player: bool = false) -> void:
	self.name_id = res.name_id
	self.is_player = is_player

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

func _to_string() -> String:
	return name_id