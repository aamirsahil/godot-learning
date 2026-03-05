extends Node

@onready var enemy_destroyed_ost = $EnemyDestroyedOST
@onready var on_click_ost = $OnClickOST

func _on_enemy_destroyed() -> void:
	enemy_destroyed_ost.play()
func _on_click() -> void:
	on_click_ost.play()
