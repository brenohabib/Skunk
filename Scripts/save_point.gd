extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	var tween = $PointLight2D.create_tween()
	tween.parallel().tween_property($PointLight2D, "texture_scale", 0.3, 1.0)