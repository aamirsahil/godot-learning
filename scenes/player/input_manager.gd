extends Node2D
@export var move_threshold := 40.0      # pixels needed for swipe move
@export var tap_time_threshold := 0.2   # quick tap = shoot
@export var move_distance := 100.0      # how far player moves per swipe

var start_time := 0.0
var touch_start_x := 0.0
var tracking_touch := false

func _input(event):
	# TOUCH START
	if event is InputEventScreenTouch and event.pressed:
		tracking_touch = true
		start_time = Time.get_ticks_msec() / 1000.0
		touch_start_x = event.position.x

	# TOUCH END
	elif event is InputEventScreenTouch and not event.pressed and tracking_touch:
		tracking_touch = false

		var end_time = Time.get_ticks_msec() / 1000.0
		var touch_end_x = event.position.x

		var delta_time = end_time - start_time
		var delta_x = touch_end_x - touch_start_x

		_handle_gesture(delta_x, delta_time)
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			start_time = Time.get_ticks_msec() / 1000.0
			touch_start_x = event.position.x
			tracking_touch = true
		else:
			var end_time = Time.get_ticks_msec() / 1000.0
			var delta_time = end_time - start_time
			var delta_x = event.position.x - touch_start_x
			tracking_touch = false
			_handle_gesture(delta_x, delta_time)

func _handle_gesture(delta_x: float, delta_time: float):
	# SWIPE MOVE
	if abs(delta_x) > move_threshold:
		if delta_x > 0:
			move_player(move_distance)
		else:
			move_player(-move_distance)
	# TAP → SHOOT
	elif delta_time < tap_time_threshold:
		shoot()
	# LONG PRESS → MISSILE
	else:
		shoot_missile()

func move_player(dx):
	$"..".move(dx)
func shoot():
	$"..".shoot()
func shoot_missile():
	$"..".shoot_missile()
