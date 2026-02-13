extends Control

signal start_game
signal quit_game

@onready var menu = $Menu

@onready var background_parent = $Menu/background_parent
@onready var background = $Menu/background_parent/background

@onready var character_parent = $Menu/character_parent
@onready var character = $Menu/character_parent/character

@onready var title_background = $Menu/TitleBackground
@onready var title = $Menu/TitleBackground/Title

@onready var v_box_container = $Menu/VBoxContainer
@onready var button_start = $Menu/VBoxContainer/Button_Start
@onready var button_quit = $Menu/VBoxContainer/Button_Quit
@onready var music = $AudioStreamPlayer

@onready var BASE_WIDTH = 1080
@onready var BASE_HEIGHT = 1920

func _ready() -> void:
	# position and scale elements
	menu.position.x = BASE_WIDTH/2
	menu.position.y = BASE_HEIGHT/2
	var background_height = background.texture.get_height()
	var target_height = 1920
	var scale_factor = float(target_height)/float(background_height)
	background_parent.scale = Vector2(scale_factor, scale_factor)
	var character_width = character.texture.get_width()
	var target_width = 1080
	scale_factor = float(target_width)/float(character_width)
	character_parent.scale = Vector2(scale_factor, scale_factor)
	title_background.size = Vector2(1080, title.size.y + 100)
	title_background.position.x = -BASE_WIDTH/2 - 1080
	v_box_container.position.y = 500
	
	# disable elements
	background.modulate.a = 0
	character.modulate.a = 0
	title.modulate.a = 0
	button_start.disabled = true
	button_quit.disabled = true
	button_start.modulate.a = 0
	button_quit.modulate.a = 0
	# tween sequence
	var tween = create_tween()
	# Background fade in
	tween.tween_property(background, "modulate:a", 1.0, 2.0)
	await tween.finished
	tween = create_tween()
	tween.tween_property(title_background, "position:x", -BASE_WIDTH/2, 2.0)
	await tween.finished
	# Music starts after background appears
	music.play()
	# Title fade in
	tween = create_tween()
	tween.tween_property(title, "modulate:a", 1.0, 1.0)
	await tween.finished
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
	print("start_game")
	emit_signal("start_game")

func _on_button_quit_pressed() -> void:
	print("quit_game")
	emit_signal("quit_game")
