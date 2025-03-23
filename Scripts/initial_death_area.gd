extends Area2D

func _on_body_entered(_body:Node2D) -> void:
    call_deferred("respawn")

func respawn() -> void:
    Musics.mute()
    get_tree().reload_current_scene()