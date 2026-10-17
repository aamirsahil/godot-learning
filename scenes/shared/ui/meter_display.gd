class_name MeterDisplay
extends Control

var _meter: Meter

func bind(meter: Meter) -> void:
	if _meter:
		_meter.value_changed.disconnect(_on_value_changed)
	_meter = meter
	self.max_value = meter.max_value
	_on_value_changed(meter.current_value, meter.max_value)
	_meter.value_changed.connect(_on_value_changed)

func _on_value_changed(current: float, max_value: float) -> void:
	var tween = create_tween()
	tween.tween_property(self, "value", current, 0.2)
