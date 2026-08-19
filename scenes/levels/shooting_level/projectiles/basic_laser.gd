class_name BasicBullet
extends Area2D

@export var speed: float = 400.0
@export var damage: int = 1

var direction: Vector2 = Vector2.RIGHT
var shooter: Node = null

@onready var lifetime_timer: Timer = $LifetimeTimer
@onready var screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

func _ready() -> void:
	lifetime_timer.timeout.connect(queue_free)
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)
	screen_notifier.screen_exited.connect(queue_free)
	rotation = direction.angle()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func get_damage() -> int:
	return damage

func _on_body_entered(body: Node2D) -> void:
	if body == shooter:
		return
	_hit()

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() == shooter:
		return
	if area is HurtBoxComponent:
		area.hit.emit(damage)
	_hit()

func _hit() -> void:
	queue_free()
