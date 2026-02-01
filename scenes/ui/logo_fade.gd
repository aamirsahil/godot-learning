extends TextureRect
%Menu
func _ready():
	# Wait for 3 seconds
	await get_tree().create_timer(10.0).timeout
	# Switch to the menu scene
	get_tree().change_scene_to_file(%Menu)
