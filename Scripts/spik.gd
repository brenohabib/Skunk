extends Area2D

@onready var timer_spik_up: Timer = $TimerSpikUp
@onready var timer_spik_down: Timer = $TimerSpikDown
@onready var spik_sprit:Sprite2D = $Spik
@onready var grand: CollisionShape2D = $grand


func _on_timer_spik_up_timeout() -> void:
	timer_spik_down.start()
	spik_sprit.frame = 5
	set_collision_mask_value(1, false)

func _on_timer_spik_down_timeout() -> void:
	timer_spik_up.start()
	spik_sprit.frame = 6
	set_collision_mask_value(1, true)
