extends Node2D

var is_active: bool = false

func _on_area_2d_body_entered(_body:Node2D) -> void:
	var tween = $PointLight2D.create_tween()
	tween.parallel().tween_property($PointLight2D, "texture_scale", 0.3, 1.0)
	is_active = true

