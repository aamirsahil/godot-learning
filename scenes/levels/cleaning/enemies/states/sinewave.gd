extends MovementState

var heading: Vector2
var elapsed: float = 0.0
@export var amplitude: float = 800.0
@export var frequency: float = 2.0

func enter() -> void:
	heading = Vector2.RIGHT.rotated(randf_range(0, TAU))

func physics_update(delta: float) -> void:
	elapsed += delta
	var perpendicular = heading.rotated(PI / 2)
	var forward_vel = heading * speed
	var wave_offset = perpendicular * cos(elapsed * frequency) * amplitude * delta
	heading = _reflect_if_out_of_bounds(heading, enemy.global_position)
	enemy.velocity = forward_vel
	enemy.move_and_slide()
	enemy.global_position += wave_offset
