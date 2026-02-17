extends Node

@onready var explosion_sound = $AudioStreamPlayer

func _on_enemy_destroyed() -> void:
	print("destroyed")
	explosion_sound.play()
