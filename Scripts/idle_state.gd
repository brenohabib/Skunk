# Estado Idle (IdleState.gd)
extends State

func enter_state() -> void:
    sprite.play("Idle")
    print("IdleState: Entrando no estado")

func physics_process_state(delta: float) -> void:
    apply_gravity(delta)
    process_horizontal_movement()
    character.move_and_slide()

func check_transitions() -> String:
    if Input.is_action_just_pressed("jump") and character.is_on_floor():
        return "JumpState"
    if character.direction != 0 and abs(character.velocity.x) > 10:
        return "MoveState"
    if !character.is_on_floor() and character.velocity.y > 0:
        return "FallState"
    return ""