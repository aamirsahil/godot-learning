extends Area2D

signal destroyed

@export var health = 1
var omega = 1
var A = float(992)/float(2)
var x0
var t = 0.0
func _ready() -> void:
	x0 = position.x/2
	
func _process(delta: float) -> void:
	t += delta
	position.x = x0 + A * sin(omega * t)

func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	print("got hit")
	health -= 1
	area.queue_free()
	if health == 0:
		destroyed.emit()
		queue_free()
