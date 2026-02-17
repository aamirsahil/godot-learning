extends Area2D

@export var speed = 2000
@onready var laser_sound = $AudioStreamPlayer

func _ready():
	laser_sound.play()
	await get_tree().create_timer(5.0).timeout
	queue_free()

func _process(delta: float) -> void:
	# move along up direction
	position.y -= speed * delta 
