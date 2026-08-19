extends MovementState

var velocity: Vector2
var direction_timer: float = 0.0

func enter() -> void:
	velocity = Vector2.RIGHT.rotated(randf_range(0, TAU)) * speed
	direction_timer = randf_range(1.0, 2.5)

func physics_update(delta: float) -> void:
	direction_timer -= delta
	if direction_timer <= 0:
		velocity = velocity.rotated(randf_range(-PI/2, PI/2))
		direction_timer = randf_range(1.0, 2.5)
	velocity = _reflect_if_out_of_bounds(velocity, enemy.global_position)
	enemy.velocity = velocity
	enemy.move_and_slide()
