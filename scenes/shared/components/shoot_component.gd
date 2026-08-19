class_name ShootComponent
extends Node

@export var projectile_scene: PackedScene
@export var cooldown: float = 0.5
@export var muzzle: Marker2D
@export var fire_sound: AudioStream

@export_flags_2d_physics var projectile_collision_layer: int
@export_flags_2d_physics var projectile_collision_mask: int
@export var damage: int = 1

var _cooldown_remaining: float = 0.0

func _process(delta: float) -> void:
	if _cooldown_remaining > 0:
		_cooldown_remaining -= delta

func can_shoot() -> bool:
	return _cooldown_remaining <= 0 and projectile_scene != null

func try_shoot(direction: Vector2, shooter: Node = null) -> void:
	if not can_shoot():
		return
	_cooldown_remaining = cooldown

	var proj = projectile_scene.instantiate()
	get_tree().current_scene.add_child(proj)
	proj.global_position = muzzle.global_position
	proj.direction = direction.normalized()
	proj.damage = damage
	proj.collision_layer = projectile_collision_layer
	proj.collision_mask = projectile_collision_mask
	proj.shooter = shooter

	AudioManager.play_sfx(fire_sound, muzzle.global_position)
