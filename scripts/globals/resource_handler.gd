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

func _ready() -> void:
	var raw = Helper.get_resources_from_dir(RESOURCE_HANDLER_RES.ai_res_dir)
	for r in raw:
		if r is AIRes:
			ai_resources.append(r)
	
	raw = Helper.get_resources_from_dir(RESOURCE_HANDLER_RES.location_res_dir)
	for r in raw:
		if r is LocationRes:
			location_resources.append(r)

	self.battle_scene = RESOURCE_HANDLER_RES.battle_scene
	self.location_scene = RESOURCE_HANDLER_RES.location_scene
	self.battle_logic_res = RESOURCE_HANDLER_RES.battle_logic_res
	self.player = RESOURCE_HANDLER_RES.player
	self.squirrel = RESOURCE_HANDLER_RES.squirrel
