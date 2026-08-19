class_name HurtBoxComponent
extends Area2D

@export var health_component: HealthComponent

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("get_damage"):
		health_component.take_damage(area.get_damage())
