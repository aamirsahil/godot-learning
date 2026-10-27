extends Node

const SAVE_PATH := "user://savegame.json"

var progress_saved:bool = false
var current_level:int = 1
var finished:bool = false

func _ready() -> void:
	load_game()

func start_new_game() -> void:
	progress_saved = false
	current_level = 1
	save_game()
	
func advance_to_level(level_number:int) -> void:
	progress_saved = true
	current_level = level_number
	save_game()
	
func load_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found. Starting with default values.")
		return
		
	var content = file.get_as_text()
	file.close()
	
	var data = JSON.parse_string(content)
	
	progress_saved = data.get("progress_saved", false)
	current_level = data.get("current_level", 1)
	finished = data.get("finished", false)
	
func save_game():
	var save_data = {
		"progress_saved" : progress_saved,
		"current_level" : current_level,
		"finished" : finished
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data, "\t"))
	file.close()

func game_finished():
	progress_saved = false
	current_level = 1
	finished = true
	save_game()
