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
	enemy.velocity = velocity
	enemy.move_and_slide()
	for i in enemy.get_slide_collision_count():
		var collision := enemy.get_slide_collision(i)
		var normal := collision.get_normal()
		velocity = velocity.bounce(normal)
