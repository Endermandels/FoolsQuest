@tool
extends Resource
class_name LootRes

@export var hp_loot_type: Constants.LootType:
	set(val):
		hp_loot_type = val
		if val == Constants.LootType.NO_CHANGE:
			hp = 0
		notify_property_list_changed()
@export_range(0, 99) var hp: int = 0: ## Acts as either a static increase or the lower bound of a random range
	set(val):
		hp = val
		if hp_loot_type == Constants.LootType.RANDOM:
			hp_hi = max(hp_hi, hp)
		else:
			hp_hi = hp
@export_range(0, 99) var hp_hi: int = 0:
	set(val):
		hp_hi = max(val, hp)

@export var mp_loot_type: Constants.LootType:
	set(val):
		mp_loot_type = val
		if val == Constants.LootType.NO_CHANGE:
			mp = 0
		notify_property_list_changed()
@export_range(0, 99) var mp: int = 0: ## Acts as either a static increase or the lower bound of a random range
	set(val):
		mp = val
		if mp_loot_type == Constants.LootType.RANDOM:
			mp_hi = max(mp_hi, mp)
		else:
			mp_hi = mp
@export_range(0, 99) var mp_hi: int = 0:
	set(val):
		mp_hi = max(val, mp)

@export var atk_loot_type: Constants.LootType:
	set(val):
		atk_loot_type = val
		if val == Constants.LootType.NO_CHANGE:
			atk = 0
		notify_property_list_changed()
@export_range(0, 99) var atk: int = 0: ## Acts as either a static increase or the lower bound of a random range
	set(val):
		atk = val
		if atk_loot_type == Constants.LootType.RANDOM:
			atk_hi = max(atk_hi, atk)
		else:
			atk_hi = atk
@export_range(0, 99) var atk_hi: int = 0:
	set(val):
		atk_hi = max(val, atk)

@export var def_loot_type: Constants.LootType:
	set(val):
		def_loot_type = val
		if val == Constants.LootType.NO_CHANGE:
			def = 0
		notify_property_list_changed()
@export_range(0, 99) var def: int = 0: ## Acts as either a static increase or the lower bound of a random range
	set(val):
		def = val
		if def_loot_type == Constants.LootType.RANDOM:
			def_hi = max(def_hi, def)
		else:
			def_hi = def
@export_range(0, 99) var def_hi: int = 0:
	set(val):
		def_hi = max(val, def)

@export var spd_loot_type: Constants.LootType:
	set(val):
		spd_loot_type = val
		if val == Constants.LootType.NO_CHANGE:
			spd = 0
		notify_property_list_changed()
@export_range(0, 99) var spd: int = 0: ## Acts as either a static increase or the lower bound of a random range
	set(val):
		spd = val
		if spd_loot_type == Constants.LootType.RANDOM:
			spd_hi = max(spd_hi, spd)
		else:
			spd_hi = spd
@export_range(0, 99) var spd_hi: int = 0:
	set(val):
		spd_hi = max(val, spd)

func _validate_property(property: Dictionary) -> void:
	if property.name in ["hp", "mp", "atk", "def", "spd"]:
		var loot_type: Constants.LootType = get(property.name + "_loot_type")

		if loot_type == Constants.LootType.NO_CHANGE:
			property.usage = PROPERTY_USAGE_NO_EDITOR
	
	if property.name.ends_with("_hi"):
		var prefix: String = property.name.split("_")[0]
		var loot_type: Constants.LootType = get(prefix + "_loot_type")

		if loot_type != Constants.LootType.RANDOM:
			property.usage = PROPERTY_USAGE_NO_EDITOR
