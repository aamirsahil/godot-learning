class_name HealthComponent
extends Node

signal died
signal health_changed(current: int, max: int)

@export var max_health: int = 3
var current_health: int

func _ready() -> void:
	current_health = max_health
	
func take_damage(amount: int) -> void:
	current_health = max(current_health - amount, 0)
	health_changed.emit(current_health, max_health)
	if current_health <= 0:
		died.emit()
