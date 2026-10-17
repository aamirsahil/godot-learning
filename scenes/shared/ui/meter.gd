# meter.gd
class_name Meter
extends Resource

signal value_changed(current: float, max_value: float)
signal depleted
signal filled

@export var max_value: float = 100.0
var current_value: float:
	set(v):
		current_value = clamp(v, 0.0, max_value)
		value_changed.emit(current_value, max_value)
		if current_value <= 0.0:
			depleted.emit()
		elif current_value >= max_value:
			filled.emit()

func _init(starting_value: float = 0.0) -> void:
	current_value = starting_value

func add(amount: float) -> void:
	current_value += amount

func subtract(amount: float) -> void:
	current_value -= amount

func set_value(v: float) -> void:
	current_value = v

func get_ratio() -> float:
	return current_value / max_value if max_value > 0 else 0.0
