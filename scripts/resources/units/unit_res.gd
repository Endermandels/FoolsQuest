@tool
extends Resource
class_name UnitRes

@export_placeholder("Wolf") var name_id: String = ""
@export var loot: LootRes
@export_group("Stats")
@export_range(1, 100) var base_hp: int = 10
@export_range(0, 20) var base_mp: int = 0
@export_range(0, 20) var base_atk: int = 0
@export_range(0, 20) var base_def: int = 0
@export_range(0, 20) var base_spd: int = 0
@export_group("Abilities")
@export var passives: Array[PassiveRes] = []
@export var specials: Array[SpecialRes] = []
