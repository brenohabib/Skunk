extends Area2D

class_name DeathZone

@export var checkpoint: Area2D
@export var checkpoint1: Area2D

@export var respawn_point: Node2D
@export var auto_respawn: bool = false 

func _on_body_entered(body: Node2D):
    if auto_respawn and respawn_point != null:
        body.global_position = respawn_point.global_position

func _on_save_point_body_entered(_body:Node2D) -> void:
    respawn_point = checkpoint

func _on_save_point_2_body_entered(_body:Node2D) -> void:
    respawn_point = checkpoint1
