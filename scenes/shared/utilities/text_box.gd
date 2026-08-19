extends Control

func _ready() -> void:
	modulate.a = 0.0
	
func display_text(name, content) -> void:
	$Panel/MarginContainer/HBoxContainer/VBoxContainer/Name.text = name
	$Panel/MarginContainer/HBoxContainer/VBoxContainer/Content.text = content
	
func render_portrait(img_src) -> void:
	var img = load(img_src)
	$Panel/MarginContainer/HBoxContainer/Portrait.texture = img
