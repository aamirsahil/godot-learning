extends Node

enum AudioKey {
	LEVEL_1_PT_1, LEVEL_1_PT_2,
	LEVEL_2_PT_1, LEVEL_2_PT_2,
	LEVEL_3_PT_1, LEVEL_3_PT_2, LEVEL_3_PT_3,
}
const AudioFiles: Dictionary = {
	AudioKey.LEVEL_1_PT_1 : "res://assets/audio/music/level_001_part_001.wav",
	AudioKey.LEVEL_1_PT_2 : "res://assets/audio/music/level_001_part_001.wav",
	AudioKey.LEVEL_2_PT_1 : "res://assets/audio/music/level_002_part_001.wav",
	AudioKey.LEVEL_2_PT_2 : "res://assets/audio/music/level_002_part_002.wav",
	AudioKey.LEVEL_3_PT_1 : "res://assets/audio/music/level_003_part_001.wav",
	AudioKey.LEVEL_3_PT_2 : "res://assets/audio/music/level_003_part_002.wav",
	AudioKey.LEVEL_3_PT_3 : "res://assets/audio/music/level_003_part_003.wav",
}

enum SpriteKey {
	
}
const SpriteFiles: Dictionary = {
	
}

enum ConfigKey {
	LEVEL_1, LEVEL_2, LEVEL_3,
	CUTSCENE_1, CUTSCENE_2, CUTSCENE_3, CUTSCENE_4
}

const ConfigFiles: Dictionary = {
	ConfigKey.LEVEL_1 : {
		"loc" : "res://scenes/level/shooting_level_config_001.json",
		"type" : "shooting_level"},
	ConfigKey.LEVEL_2 : {
		"loc" : "res://scenes/level/shooting_level_config_002.json",
		"type" : "shooting_level"},
	ConfigKey.LEVEL_3 : {
		"loc" : "res://scenes/level/shooting_level_config_003.json",
		"type" : "shooting_level"},
	ConfigKey.CUTSCENE_1 : {
		"loc" : "res://scenes/level/cutscene_config_001.json",
		"type" : "cutscene"},
	ConfigKey.CUTSCENE_2 : {
		"loc" : "res://scenes/level/cutscene_config_002.json",
		"type" : "cutscene"},
	ConfigKey.CUTSCENE_3 : {
		"loc" : "res://scenes/level/cutscene_config_003.json",
		"type" : "cutscene"},
	ConfigKey.CUTSCENE_4 : {
		"loc" : "res://scenes/level/cutscene_config_004.json",
		"type" : "cutscene"},
}

enum SceneKey {
	SPLASH,
	MAIN_MENU,
	LEVEL_MANAGER,
	CUTSCENE,
	SHOOTING_LEVEL_TEMPLATE,
	TEXT_BOX
}
const SceneFiles: Dictionary = {
	SceneKey.SPLASH : preload("res://scenes/ui/splash_scene.tscn"),
	SceneKey.MAIN_MENU : preload("res://scenes/ui/main_menu.tscn"),
	SceneKey.LEVEL_MANAGER : preload("res://scenes/level/level_manager.tscn"),
	SceneKey.CUTSCENE : preload("res://scenes/utilities/cutscene.tscn"),
	SceneKey.SHOOTING_LEVEL_TEMPLATE : preload("res://scenes/level/level_templates/shooting_level_template.tscn"),
	SceneKey.TEXT_BOX : preload("res://scenes/utilities/text_box.tscn")
}

func get_audio(key: AudioKey):
	return _safe_get(AudioFiles, key)

func get_sprite(key: SpriteKey):
	return _safe_get(SpriteFiles, key)

func get_config(key: ConfigKey):
	return _safe_get(ConfigFiles, key)
	
func get_scene(key: SceneKey):
	return _safe_get(SceneFiles, key)
	
func _safe_get(dict: Dictionary, key: int):
	if not dict.has(key):
		push_error("Asset key not found: " + str(key))
		return null
	return dict[key]
