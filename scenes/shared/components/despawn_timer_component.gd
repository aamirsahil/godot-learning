class_name DespawnTimerComponent
extends Node

signal timed_out
signal blink_started

@export var lifetime: float = 8.0
@export var blink_warning_time: float = 2.0

var _time_remaining: float
var _blink_emitted: bool = false

func _ready() -> void:
	_time_remaining = lifetime

func _process(delta: float) -> void:
	_time_remaining -= delta
	if not _blink_emitted and _time_remaining <= blink_warning_time:
		_blink_emitted = true
		blink_started.emit()
	if _time_remaining <= 0:
		timed_out.emit()
		set_process(false)

func cancel() -> void:
	set_process(false)
