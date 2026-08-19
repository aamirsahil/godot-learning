extends Node

const POOL_SIZE = 12

var _pool: Array[AudioStreamPlayer2D] = []
var _next_index: int = 0

func _ready() -> void:
	for i in POOL_SIZE:
		var p = AudioStreamPlayer2D.new()
		add_child(p)
		_pool.append(p)

func play_sfx(stream: AudioStream, position: Vector2, volume_db: float = 0.0) -> void:
	if not stream:
		return
	var player = _pool[_next_index]
	_next_index = (_next_index + 1) % POOL_SIZE
	player.stream = stream
	player.global_position = position
	player.volume_db = volume_db
	player.play()
