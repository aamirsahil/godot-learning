extends Control

signal finished

@onready var logo_node = $Logo
@onready var logo = $Logo/Logo
@onready var music = $AudioStreamPlayer

@onready var BASE_WIDTH = 1080
@onready var BASE_HEIGHT = 1920
@onready var target_width = 1080
@onready var scale_offset = 1.0

@onready var logo_width = logo.texture.get_width()
@onready var scale_factor = float(target_width) / float(logo_width)

func _ready():
	# set logo properties
	set_logo()
	# play music
	music.play()
	# animate
	animate(scale_factor)
	# Wait for 3.5 seconds
	await get_tree().create_timer(3.5).timeout
	emit_signal("finished")
	
func set_logo() -> void:
	logo.modulate[3] = 0.0
	logo_node.position.x = BASE_WIDTH/2
	logo_node.position.y = BASE_HEIGHT/2
	logo_node.scale = Vector2(0.0, 0.0)

func animate(scale_factor:float) -> void:
	var tween = create_tween()
	# Fade in logo
	tween.parallel().tween_property(logo, "modulate:a", 1.0, 2.0)
	# Pop in logo
	tween.parallel().tween_property(
		logo_node,
		"scale", Vector2(scale_factor + scale_offset, scale_factor + scale_offset),
		1.6).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		logo_node,
		"scale", Vector2(scale_factor, scale_factor),
		0.4).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	
