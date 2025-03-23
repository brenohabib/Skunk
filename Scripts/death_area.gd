extends Area2D

class_name DeathZone

@export var respawn_point: Node2D
@export var auto_respawn: bool = false 

func _on_body_entered(body: Node2D):
    if auto_respawn and respawn_point != null:
        body.global_position = respawn_point.global_position
