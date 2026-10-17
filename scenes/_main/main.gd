extends Node

@onready var continue_button: Button = $UI/ButtonContainer/Continue
@onready var select_chapter_button: Button = $UI/ButtonContainer/SelectChapter

@export var progress_saved:bool = false

func _ready() -> void:
	continue_button.visible = progress_saved
	select_chapter_button.visible = progress_saved
