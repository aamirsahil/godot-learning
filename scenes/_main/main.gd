extends Node

@onready var continue_button: Button = $UI/ButtonContainer/Continue
@onready var select_chapter_button: Button = $UI/ButtonContainer/SelectChapter

func _ready() -> void:
	continue_button.visible = SaveManager.progress_saved
	select_chapter_button.visible = SaveManager.progress_saved


func _on_new_game_pressed() -> void:
	LevelManager.start_new_game()

func _on_quit_pressed() -> void:
	LevelManager.quit_game()

func _on_continue_pressed() -> void:
	LevelManager.load_level(SaveManager.current_level)
