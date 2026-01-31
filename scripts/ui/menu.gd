extends Control

@onready var label      = $ColorRect/VBoxContainer/HBoxContainer/Label
@onready var color_rect = $ColorRect
@onready var logo       = $Logo
@onready var music      = $AudioStreamPlayer

func _ready():
	music.play()
	# Initial states (safety)
	label.modulate.a = 0.0
	logo.modulate.a = 0.0
	var tween = create_tween()

	# Fade in label (5 seconds)
	tween.tween_property(label, "modulate:a", 1.0, 5.0)

	# Fade ColorRect to black (after label fade)
	tween.tween_property(
		color_rect,
		"color",
		Color.BLACK,
		2.0
	)
	# Fade in logo
	tween.tween_property(logo, "modulate:a", 1.0, 2.0)
