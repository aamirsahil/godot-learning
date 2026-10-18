class_name Enemy
extends CharacterBody2D

@export var data: EnemyData

@onready var health_component: HealthComponent = $HealthComponent
@onready var despawn_timer: DespawnTimerComponent = $DespawnTimerComponent
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	health_component.max_health = data.max_health
	health_component.died.connect(_on_killed_by_player)
	despawn_timer.timed_out.connect(_on_timed_out)
	despawn_timer.blink_started.connect(_start_blinking)

func _on_killed_by_player() -> void:
	despawn_timer.cancel()
	_fade_despawn()

func _on_timed_out() -> void:
	_explode_despawn()

func _start_blinking() -> void:
	var tween = create_tween().set_loops()
	tween.tween_property(sprite, "modulate:a", 0.2, 0.15)
	tween.tween_property(sprite, "modulate:a", 1.0, 0.15)

func _fade_despawn() -> void:
	AudioManager.play_sfx(data.death_sound, global_position)
	var tween = create_tween()
	tween.tween_property(sprite, "modulate:a", 0.0, 0.4)
	tween.tween_callback(queue_free)

func _explode_despawn() -> void:
	AudioManager.play_sfx(data.explosion_sound, global_position)
	#ScoreManager.add_penalty()   # "meter goes up" — see note below
	#var explosion = preload("res://shared/effects/explosion.tscn").instantiate()
	#get_tree().current_scene.add_child(explosion)
	#explosion.global_position = global_position
	queue_free()
