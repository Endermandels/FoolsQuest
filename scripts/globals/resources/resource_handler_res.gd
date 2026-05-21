extends Resource
class_name ResourceHandlerRes

@export_group("Scenes")
@export_file_path("*.tscn") var battle_scene: String = ""
@export_file_path("*.tscn") var location_scene: String = ""
@export_file_path("*.tscn") var victory_scene: String = ""
@export_group("Directories")
@export_dir var ai_res_dir: String = ""
@export_dir var location_res_dir: String = ""
@export_group("Resources")
@export var dragon_location: LocationRes
@export var battle_logic_res: BattleLogicRes
@export var player: UnitRes
@export var squirrel: UnitRes
