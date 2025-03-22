extends Area2D

@export var interact_menu: CanvasLayer

func _on_body_exited(_body:Node2D) -> void:
	interact_menu.hide()

func _on_body_entered(_body:Node2D) -> void:
	interact_menu.show()

func _input(_event: InputEvent) -> void:
	if interact_menu.visible == true and Input.is_action_just_pressed("interact"):
		interact_menu.hide()
		