extends Node

var laser_scene: PackedScene = preload("res://scenes/objects/laser.tscn")

signal done(level_num)
signal quit_game

@onready var sound_effects = $SoundEffects
@onready var enemies = $Enemies

@onready var notification = $Texts/Notification
var notification_texts
var next_level
@onready var ammo_text = $Texts/AmmoText

@onready var player = $Player
@onready var music = $LevelOST

#func _ready() -> void:
	#play(Global.get_config(Global.ConfigKey.LEVEL_1)["loc"])

func play(file_path) -> void:
	var level_config = _read_data(file_path)
	notification_texts = [level_config["objective_text"], level_config["failure_text"], level_config["congrats_text"]]
	notification.modulate.a = 1.0
	player.laser_ammo = level_config["player"]["ammo"]
	#player.position = Vector2(3*1080.0/5 + 180, 1920.0 - 60)
	player.position = Vector2(519.0, 1773.0)
	ammo_text.text = "Ammo : " + str(player.laser_ammo)
	
	music.stream = load(level_config["music"])
	music.play()
	
	notification.text = notification_texts[0]
	
	for enemy_config in level_config["enemies"]:
		var enemy_scene: PackedScene = load(enemy_config["scene"])
		var enemy = enemy_scene.instantiate()
		enemy.position = Vector2(enemy_config["position"][0]*1080.0/5 + 90, enemy_config["position"][1]*1920.0/10 + 110)
		enemies.add_child(enemy)
		enemy.destroyed.connect(_on_enemy_destroyed)
		
	await get_tree().create_timer(2.0).timeout
	notification.modulate.a = 0.0
		
func _on_player_laser_shot(pos) -> void:
	var laser = laser_scene.instantiate()
	laser.position = pos
	$Projectiles.add_child(laser)
	ammo_text.text = "Ammo : " + str(player.laser_ammo)

func _on_player_ammo_done() -> void:
	await get_tree().create_timer(2.0).timeout
	_check_level_state()
	
func _read_data(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		push_error("could not find the file " + file_path)
		return
	
	var json_text = file.get_as_text()
	file.close()
	
	var parsed = JSON.parse_string(json_text)
	
	if parsed == null:
		push_error("Invalid JSON in " + file_path)
		return
		
	return parsed

func _check_level_state():
	if len(enemies.get_children()) == 0:
		_level_won()
	elif player.laser_ammo == 0:
		_level_lost()

func _level_won():
	notification.text = notification_texts[2]
	notification.modulate.a = 1.0
	await get_tree().create_timer(2.0).timeout
	done.emit()

func _level_lost():
	notification.text = notification_texts[1]
	notification.modulate.a = 1.0
	await get_tree().create_timer(2.0).timeout
	done.emit()
	
func _on_enemy_destroyed():
	sound_effects._on_enemy_destroyed()
	await get_tree().process_frame
	_check_level_state()
