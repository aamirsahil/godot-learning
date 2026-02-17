extends CharacterBody2D

signal laser_shot(position)
signal missile_shot

var player_pos = 2

func move(dx: float = 0) -> void:
	if dx > 0 and player_pos < 4:
		position.x += dx
		player_pos += 1
	elif dx < 0 and player_pos > 0:
		position.x += dx
		player_pos -= 1
	else:
		print("hit wall")
func shoot() -> void:
	laser_shot.emit(global_position)
func shoot_missile() -> void:
	missile_shot.emit()
	print("shoot missile")
