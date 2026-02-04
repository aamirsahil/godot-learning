extends Sprite2D

func _ready():
	fit_to_screen()

func fit_to_screen():
	var screen_size = get_viewport_rect().size
	var tex_size = texture.get_size()

	# Center sprite
	position = screen_size * 0.5

	# Scale to cover the screen (like CSS background-size: cover)
	var scale_factor = min(
		screen_size.x / tex_size.x,
		screen_size.y / tex_size.y
	)

	scale = Vector2.ONE * scale_factor
