extends Node

var splash_scene = preload("res://scenes/screens/splash_scene.tscn")
var main_menu_scene = preload("res://scenes/screens/main_menu.tscn")
var level_manager_scene = preload("res://scenes/screens/level/level_manager.tscn")

var current_scene

func _ready() -> void:
	show_splash()
	
func show_splash() -> void:
	switch_scene(splash_scene)
	current_scene.finished.connect(show_main_menu)
	
func show_main_menu() -> void:
	switch_scene(main_menu_scene)
	current_scene.start_game.connect(show_level)
	current_scene.quit_game.connect(quit_game)

func show_level():
	switch_scene(level_manager_scene)
	current_scene.back_to_menu.connect(show_main_menu)
	
func quit_game():
	get_tree().quit()
	
func switch_scene(scene):
	if current_scene:
		current_scene.queue_free()
	current_scene = scene.instantiate()
	add_child(current_scene)
