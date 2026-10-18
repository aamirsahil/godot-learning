class_name EnemyData
extends Resource

@export var display_name: String = "Enemy"
@export var speed: float = 100.0
@export var max_health: int = 3
@export var damage: int = 1
@export var death_sound: AudioStream
@export var explosion_sound: AudioStream

# behavior tuning values, used by whichever state needs them
@export var detection_radius: float = 150.0
@export var wander_radius: float = 150.0
@export var move_duration: float = 5.0
@export var shoot_interval: float = 2.0
@export var projectile_scene: PackedScene
