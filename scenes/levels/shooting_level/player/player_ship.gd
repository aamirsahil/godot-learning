extends Node2D

var laser_scene = preload("res://scenes/objects/laser.tscn")

func _on_ship_laser_shot(position: Vector2) -> void:
	var laser = laser_scene.instantiate()
	laser.direction = 1.0
	add_child(laser)
	laser.global_position = position
