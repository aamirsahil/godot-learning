extends Node

@onready var enemy_destroyed_ost = $EnemyDestroyedOST

func _on_enemy_destroyed() -> void:
	enemy_destroyed_ost.play()
