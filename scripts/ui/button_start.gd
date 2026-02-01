extends Button
@onready var level1 = "res://scenes/ui/level1.tscn"
func _on_pressed():
	get_tree().change_scene_to_file(level1)
