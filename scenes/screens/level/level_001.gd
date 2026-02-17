extends Node2D

#signal level_retry
#signal back_to_menu

var laser_scene: PackedScene = preload("res://scenes/entity/projectiles/laser.tscn")

@onready var explosion = $ObjectParent/Explosion
@onready var enemies = $ObjectParent/Enemies

func _ready() -> void:
	for e in enemies.get_children():
		e.destroyed.connect(explosion._on_enemy_destroyed)

func _on_player_laser_shot(pos) -> void:
	var laser = laser_scene.instantiate()
	laser.position = pos
	$ObjectParent/Projectiles.add_child(laser)
	print("shoot")
