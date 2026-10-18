extends CharacterBody2D

var speed = 600
var laser_ammo = 100
@onready var shoot_component: ShootComponent = $ShootComponent

func _physics_process(_delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction*speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		if laser_ammo <= 0:
			print("No ammo")
		else:
			shoot_component.try_shoot(Vector2.UP, self)
	elif event.is_action_pressed("shoot_missile"):
		pass
