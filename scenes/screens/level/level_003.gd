extends Node2D

var laser_scene: PackedScene = preload("res://scenes/entity/projectiles/laser.tscn")

signal done(level_num)
signal quit_game

@onready var explosion = $ObjectParent/Explosion
@onready var enemies = $ObjectParent/Enemies

@onready var objective_text = $ObjectParent/Texts/objective
@onready var congrats_text = $ObjectParent/Texts/congrats
@onready var failure_text = $ObjectParent/Texts/failure
@onready var ammo_text = $ObjectParent/Texts/Ammo_text

@onready var player = $ObjectParent/Player
@onready var music = $AudioStreamPlayer

func _ready() -> void:
	music.play()
	objective_text.modulate.a = 1.0
	print(player.laser_ammo)
	player.laser_ammo = 5
	ammo_text.text = "Ammo : " + str(player.laser_ammo)
	var i = 0
	for e in enemies.get_children():
		if i==0:
			e.omega = -e.omega
		e.destroyed.connect(explosion._on_enemy_destroyed)
		e.destroyed.connect($"."._on_enemy_destroyed)
		i+=1
		
	await get_tree().create_timer(2.0).timeout
	objective_text.modulate.a = 0.0

func _on_enemy_destroyed():
	if len(enemies.get_children()) == 1:
		_on_player_ammo_done()

func _on_player_laser_shot(pos) -> void:
	var laser = laser_scene.instantiate()
	laser.position = pos
	$ObjectParent/Projectiles.add_child(laser)
	ammo_text.text = "Ammo : " + str(player.laser_ammo)
	print("shoot")


func _on_player_ammo_done() -> void:
	await get_tree().create_timer(2.0).timeout
	if len(enemies.get_children()) > 0:
		failure_text.modulate.a = 1.0
	else:
		congrats_text.modulate.a = 1.0
	await get_tree().create_timer(2.0).timeout
	quit_game.emit()
