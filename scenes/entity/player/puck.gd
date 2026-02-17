extends RigidBody2D

@export var push_force := 500.0

var initial_pos: Vector2
var drag_start := false

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		# Mouse pressed
		if event.pressed:
			initial_pos = get_global_mouse_position()
			# correct distance check
			var dist = global_position.distance_to(initial_pos)
			if dist < 30:   # click radius threshold
				drag_start = true
		# Mouse released
		elif drag_start:
			var final_pos = get_global_mouse_position()
			var direction = -(final_pos - initial_pos).normalized()
			apply_central_impulse(direction * push_force)
			drag_start = false
