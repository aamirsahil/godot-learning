extends Control

signal finished

@onready var logo_node = $CenterContainer
@onready var logo = $CenterContainer/Logo/Logo
@onready var music = $Luna1LogoOST

@onready var target_width = 1080
@onready var scale_offset = 1.0

@onready var logo_width = logo.texture.get_width() 

@export var fade_in_time = 2.0
@export var pop_in_time = 1.6
@export var pop_out_time = 0.4

func _ready():
	var scale_factor = float(target_width) / float(logo_width)
	_set_logo()
	# play music
	music.play()
	_animate(scale_factor)
	# Wait for 3.5 seconds
	await get_tree().create_timer(3.5).timeout
	
	emit_signal("finished")
	print("Signal emitted : finished | Splash screen done")
	
func _set_logo() -> void:
	logo.modulate.a = 0.0
	logo_node.scale = Vector2(0.0, 0.0)

func _animate(scale_factor: float) -> void:
	var tween = create_tween()
	# Fade in logo
	tween.parallel().tween_property(logo, "modulate:a", 1.0, fade_in_time)
	# Pop in logo
	tween.parallel().tween_property(
		logo_node,
		"scale", Vector2(scale_factor + scale_offset, scale_factor + scale_offset),
		pop_in_time).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		logo_node,
		"scale", Vector2(scale_factor, scale_factor),
		pop_out_time).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
