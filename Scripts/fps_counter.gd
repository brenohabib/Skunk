extends Control

@onready var label: Label = $Label

func _process(delta: float) -> void:
	label.text = "FPS: " + str(round(1.0 / delta))
