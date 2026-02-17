extends Node

var level_001_scene = preload("res://scenes/screens/level/level_001.tscn")
var level_002_scene = preload("res://scenes/screens/level/level_002.tscn")

signal back_to_menu

var current_scene

func _ready() -> void:
	show_level(0)
	
func show_level(level_num:int) -> void:
	if level_num == 0:
		switch_scene(level_001_scene)
	elif level_num == 1:
		switch_scene(level_002_scene)
	current_scene.done.connect(show_level)
	current_scene.quit_game.connect(show_menu)
	
func show_menu() -> void:
	back_to_menu.emit()
	
func switch_scene(scene):
	if current_scene:
		current_scene.queue_free()
	current_scene = scene.instantiate()
	add_child(current_scene)
