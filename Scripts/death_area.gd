extends Area2D

class_name DeathZone

@export var checkpoint: Area2D
@export var checkpoint1: Area2D
@export var checkpoint2: Area2D
@export var checkpoint3: Area2D

@export var respawn_point: Node2D

var is_fire_active = false

func _on_body_entered(body: Node2D):
    if respawn_point != null:
        body.global_position = respawn_point.global_position

func _on_ice_spik_body_entered(body:Node2D) -> void:
    if respawn_point != null:
        body.global_position = respawn_point.global_position

func _on_fir_body_entered(body:Node2D) -> void:
    if respawn_point != null and is_fire_active:
        body.global_position = respawn_point.global_position

func _on_save_point_body_entered(_body:Node2D) -> void:
    respawn_point = checkpoint

func _on_save_point_2_body_entered(_body:Node2D) -> void:
    respawn_point = checkpoint1

func _on_save_point_3_body_entered(_body:Node2D) -> void:
    respawn_point = checkpoint2

func _on_save_point_4_body_entered(_body:Node2D) -> void:
    respawn_point = checkpoint3

func _on_death_body_entered(_body:Node2D) -> void:
    is_fire_active = true
