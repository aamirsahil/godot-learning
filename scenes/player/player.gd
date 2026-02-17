extends CharacterBody2D

signal laser_shot(position)
signal ammo_done
signal missile_shot

var player_pos = 2
var laser_ammo = 10

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
	if laser_ammo > 0:
		laser_ammo -= 1
		laser_shot.emit(global_position)
	if laser_ammo < 1:
		ammo_done.emit()
		print("ammo_depleted")
func shoot_missile() -> void:
	missile_shot.emit()
	print("shoot missile")
