extends Control

@onready var logo       = $Logo
@onready var music      = $AudioStreamPlayer
@onready var menu_scene = "res://scenes/ui/Main_Menu.tscn"
func _ready():
	music.play()
	# Initial states (safety)
	var tween = create_tween()
	# Fade in logo
	tween.tween_property(logo, "modulate:a", 1.0, 2.0)
	# Wait for 3 seconds
	await get_tree().create_timer(10.0).timeout
	# Switch to the menu scene
	get_tree().change_scene_to_file(menu_scene)
