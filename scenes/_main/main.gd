extends Node

@onready var continue_button: Button = $UI/ButtonContainer/Continue
@onready var select_chapter_button: Button = $UI/ButtonContainer/SelectChapter

func _ready() -> void:
	continue_button.visible = SaveManager.progress_saved
	select_chapter_button.visible = SaveManager.progress_saved
