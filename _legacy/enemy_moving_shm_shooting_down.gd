extends Area2D
signal destroyed

var laser_scene = preload("res://scenes/objects/laser_enemy.tscn")

@export var health = 1
@export var shooting_timer = 5.0

var omega = 1
var A = float(992)/float(2)
var x0
var t = 0.0
var direction = 1.0
var current_timer = 2.0

func _ready() -> void:
	x0 = position.x
	
func _process(delta: float) -> void:
	t += direction*delta
	position.x = x0 + A * sin(omega * t)
	current_timer -= delta
	if current_timer < 0:
		shoot()
		current_timer = shooting_timer

func shoot():
	var laser = laser_scene.instantiate()
	laser.direction = -1.0
	add_child(laser)
	laser.global_position = global_position
	

func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area is PlayerProjectile:
		print("got hit")
		health -= 1
		area.queue_free()
		if health == 0:
			destroyed.emit()
			queue_free()
