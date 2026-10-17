extends Node

var _meter: Meter = Meter.new()
@onready var meter_display: MeterDisplay = $UI/MeterDisplay

func _ready() -> void:
	meter_display.bind(_meter)
	
func _process(delta: float) -> void:
	_meter.add(delta*5)
