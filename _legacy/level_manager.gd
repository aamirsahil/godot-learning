extends Node

var cutscene_scene = Global.get_scene(Global.SceneKey.CUTSCENE)
var shootingleveltemplate_scene = Global.get_scene(Global.SceneKey.SHOOTING_LEVEL_TEMPLATE)
var curr_event_num = 0

var event_order = [
	Global.get_config(Global.ConfigKey.CUTSCENE_1),
	Global.get_config(Global.ConfigKey.LEVEL_1),
	Global.get_config(Global.ConfigKey.CUTSCENE_2),
	Global.get_config(Global.ConfigKey.LEVEL_2),
	Global.get_config(Global.ConfigKey.CUTSCENE_3),
	Global.get_config(Global.ConfigKey.LEVEL_3),
	Global.get_config(Global.ConfigKey.CUTSCENE_4)
]

signal back_to_menu

var current_scene

func _ready() -> void:
	show(event_order[curr_event_num])
	
func show(event: Dictionary) -> void:
	curr_event_num += 1
	if curr_event_num >= len(event_order):
		show_menu()
		return

	if event["type"] == "cutscene":
		switch_scene(cutscene_scene)
		current_scene.play(event["loc"])

	elif event["type"] == "shooting_level":
		switch_scene(shootingleveltemplate_scene)
		current_scene.play(event["loc"])
	
	if not current_scene.done.is_connected(_on_scene_done):
		current_scene.done.connect(_on_scene_done)
	current_scene.quit_game.connect(show_menu)

func _on_scene_done():
	show(event_order[curr_event_num])

func show_menu() -> void:
	back_to_menu.emit()
	print("Signal Emitted : back_to_menu")
	
func switch_scene(scene):
	if current_scene:
		current_scene.queue_free()
	current_scene = scene.instantiate()
	add_child(current_scene)
