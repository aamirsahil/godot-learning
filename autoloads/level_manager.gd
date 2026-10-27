extends Node

const MAIN_MENU:String = "res://scenes/_main/main.tscn"
var current_level:String = "cleaning"

const LEVEL_NAMES: Array[String] = [
	"cleaning", "water", "kitchen", "traffic", "computer",
	 "rhythm", "crossing", "hospital", "apocalypse", "restoration"
]

const LEVELS: Array[String] = [
	"res://scenes/levels/cleaning/level.tscn", 
	"res://scenes/levels/water/level.tscn", 
	"res://scenes/levels/kitchen/level.tscn", 
	"res://scenes/levels/traffic/level.tscn", 
	"res://scenes/levels/computer/level.tscn",
	"res://scenes/levels/rhythm/level.tscn",
	"res://scenes/levels/crossing/level.tscn",
	"res://scenes/levels/hospital/level.tscn",
	"res://scenes/levels/apocalypse/level.tscn",
	"res://scenes/levels/restoration/level.tscn"
]

func start_new_game() -> void:
	SaveManager.start_new_game()
	load_level(1)
	
func load_level(level_number: int) -> void:
	if level_number < 1 or level_number > LEVELS.size():
		return
	current_level = LEVEL_NAMES[level_number - 1]
	get_tree().change_scene_to_file(LEVELS[level_number - 1])
	
func advance_level() -> void:
	var next_level = SaveManager.current_level + 1
	
	if next_level > LEVELS.size():
		SaveManager.game_finished()
		return_to_mainmenu()
		return
		
	SaveManager.advance_to_level(next_level)
	load_level(next_level)
	
func return_to_mainmenu() -> void:
	get_tree().change_scene_to_file(MAIN_MENU)
	
func quit_game() -> void:
	get_tree().quit()
