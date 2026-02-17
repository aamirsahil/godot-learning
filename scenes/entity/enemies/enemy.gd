extends Area2D

signal destroyed

@export var health = 5

func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	print("got hit")
	health -= 1
	area.queue_free()
	if health == 0:
		destroyed.emit()
		queue_free()
