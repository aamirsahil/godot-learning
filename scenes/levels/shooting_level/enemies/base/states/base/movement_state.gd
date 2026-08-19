class_name MovementState
extends State

@export var play_area: Rect2 = Rect2(Vector2(0, 0), Vector2(1920, 800))
@export var speed: float = 300.0

func _reflect_if_out_of_bounds(vel: Vector2, pos: Vector2) -> Vector2:
	var new_vel = vel
	if pos.x < play_area.position.x or pos.x > play_area.end.x:
		new_vel.x *= -1
	if pos.y < play_area.position.y or pos.y > play_area.end.y:
		new_vel.y *= -1
	return new_vel
