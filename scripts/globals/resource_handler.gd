extends Node
# Global

# The purpose of this file is to load and store resources 
# that would normally have to be preloaded

const RESOURCE_HANDLER_RES := preload("res://resources/resource_handler.tres")

# Scenes
var battle_scene: String
var location_scene: String

# Directories
var ai_resources: Array[AIRes]
var location_resources: Array[LocationRes]

# Resources
var battle_logic_res: BattleLogicRes
var player: UnitRes
var squirrel: UnitRes
var dragon_location: LocationRes

func _get_resources_from_dir(dir_path: String) -> Array[Resource]:
	var res: Array[Resource] = []

	var dir := DirAccess.open(dir_path)
	if dir != null:
		dir.list_dir_begin()
		var file := dir.get_next()
		while file != "":
			if file.ends_with(".tres"):
				res.append(load(dir_path.path_join(file)))
			file = dir.get_next()
		dir.list_dir_end()

	return res

func _ready() -> void:
	var raw = _get_resources_from_dir(RESOURCE_HANDLER_RES.ai_res_dir)
	for r in raw:
		if r is AIRes:
			ai_resources.append(r)
	
	raw = _get_resources_from_dir(RESOURCE_HANDLER_RES.location_res_dir)
	for r in raw:
		if r is LocationRes:
			location_resources.append(r)

	self.battle_scene = RESOURCE_HANDLER_RES.battle_scene
	self.location_scene = RESOURCE_HANDLER_RES.location_scene
	self.battle_logic_res = RESOURCE_HANDLER_RES.battle_logic_res
	self.player = RESOURCE_HANDLER_RES.player
	self.squirrel = RESOURCE_HANDLER_RES.squirrel
	self.dragon_location = RESOURCE_HANDLER_RES.dragon_location
