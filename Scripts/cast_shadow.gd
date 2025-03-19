extends Node2D

@onready var raycast: RayCast2D = $RayCast2D
@onready var shadow: Sprite2D = $Sprite2D

var raycast_colision_point : float = 0.0

func _physics_process(_delta: float) -> void:
	if raycast.is_colliding():
		raycast_colision_point = raycast.get_collision_point().y
	else:
		raycast_colision_point = raycast.global_position.y + raycast.target_position.y
	
	shadow.global_position.y = raycast_colision_point
	shadow.modulate.a = max(1.0 - shadow.position.y / 64, 0.0)