# Estado de Movimento (MoveState.gd)
extends State

func enter_state() -> void:
    # sprite.play("Run")
    print("MoveState: Entrando no estado")

func physics_process_state(delta: float) -> void:
    apply_gravity(delta)
    process_horizontal_movement()
    character.move_and_slide()

func check_transitions() -> String:
    if abs(character.velocity.x) < 10 and character.direction == 0:
        return "IdleState"
    if Input.is_action_just_pressed("ui_accept") and character.is_on_floor():
        return "JumpState"
    if !character.is_on_floor() and character.velocity.y > 0:
        return "FallState"
    return ""