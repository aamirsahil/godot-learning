extends MovementState

var velocity: Vector2

func enter() -> void:
	velocity = Vector2.RIGHT.rotated(randf_range(0, TAU)) * speed

func physics_update(delta: float) -> void:
	velocity = _reflect_if_out_of_bounds(velocity, enemy.global_position)
	enemy.velocity = velocity
	enemy.move_and_slide()
