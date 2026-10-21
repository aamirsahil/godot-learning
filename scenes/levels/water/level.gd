extends Node

@onready var label: Label = $UI/Label
var input_enabled = false

func _ready() -> void:
	label.text = "Playing " + LevelManager.current_level + " level" \
	+ "\nPress (W) to move to next level" \
	+ "\nPress (S) to return to main menu"
	label.add_theme_font_size_override("font_size", 50)
	await get_tree().create_timer(1.0).timeout
	input_enabled = true
	
func _unhandled_input(event: InputEvent) -> void:
	if not input_enabled:
		return
		
	if event.is_action("advance_level"):
		LevelManager.advance_level()
		
	elif  event.is_action("return_to_menu"):
		LevelManager.return_to_mainmenu()
