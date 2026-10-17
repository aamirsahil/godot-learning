extends MovementState

var velocity: Vector2

func enter() -> void:
	velocity = Vector2.RIGHT.rotated(randf_range(0, TAU)) * speed

func physics_update(delta: float) -> void:
	enemy.velocity = velocity
	enemy.move_and_slide()
	
	for i in enemy.get_slide_collision_count():
		var collision = enemy.get_slide_collision(i)
		var normal = collision.get_normal()
		velocity = velocity.bounce(normal)
