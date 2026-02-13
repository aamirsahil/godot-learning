extends CharacterBody2D

func move(dx: float = 0) -> void:
	position.x += dx
func shoot() -> void:
	print("shoot")
func shoot_missile() -> void:
	print("shoot missile")
