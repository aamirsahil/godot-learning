extends Control

signal start_game
signal quit_game

@onready var background = $Background
@onready var star1 = $Star1
@onready var star2 = $Star2
@onready var character = $Character
@onready var title_background = $TitleBackground
@onready var title = $Title

@onready var v_box_container = $CenterContainer/MarginContainer/VBoxContainer
@onready var button_start = $CenterContainer/MarginContainer/VBoxContainer/Button_Start
@onready var button_quit = $CenterContainer/MarginContainer/VBoxContainer/Button_Quit
@onready var music = $MainMenuOST

func _ready() -> void:
	# disable elements
	background.modulate.a = 0
	star1.modulate.a = 0
	star2.modulate.a = 0
	character.modulate.a = 0
	title.modulate.a = 0
	button_start.disabled = true
	button_quit.disabled = true
	button_start.modulate.a = 0
	button_quit.modulate.a = 0

	music.play()
	
	# tween sequence
	var tween = create_tween()
	# Background fade in
	tween.tween_property(background, "modulate:a", 1.0, 2.0)
	await tween.finished
	tween = create_tween()
	tween.parallel().tween_property(title_background, "position:x", 0.0, 2.0)
	tween.parallel().tween_property(star1, "modulate:a", 1.0, 2.0)
	await tween.finished
	start_twinkle(star1, 0.8, 0.0)
	# Title fade in
	tween = create_tween()
	tween.parallel().tween_property(title, "modulate:a", 1.0, 1.0)
	tween.parallel().tween_property(star2, "modulate:a", 1.0, 2.0)
	await tween.finished
	start_twinkle(star2, 1.1, 0.4)
	# Character fade in
	tween = create_tween()
	tween.tween_property(character, "modulate:a", 1.0, 1.2)
	await tween.finished

	# Buttons fade in together
	tween = create_tween()
	tween.parallel().tween_property(button_start, "modulate:a", 1.0, 0.8)
	tween.parallel().tween_property(button_quit, "modulate:a", 1.0, 0.8)
	button_start.disabled = false
	button_quit.disabled = false

func _on_button_start_pressed() -> void:
	emit_signal("start_game")
	print("Signal Emitted : start_game")

func _on_button_quit_pressed() -> void:
	emit_signal("quit_game")
	print("Signal Emitted : quit_game")

func start_twinkle(star: Control, duration: float, delay: float = 0.0) -> void:
	var tween = create_tween()
	tween.set_loops()
	
	if delay > 0.0:
		tween.tween_interval(delay)
	
	tween.tween_property(star, "modulate:a", 0.2, duration)
	tween.tween_property(star, "modulate:a", 1.0, duration)
