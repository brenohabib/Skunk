# Estado de Pulo (JumpState.gd)
extends State

func enter_state() -> void:
    # sprite.play("Jump")
    print("JumpState: Entrando no estado")
    character.velocity.y = -character.JUMP_VELOCITY

func physics_process_state(delta: float) -> void:
    apply_gravity(delta)
    process_horizontal_movement(true)  # true = controle aéreo
    character.move_and_slide()

func check_transitions() -> String:
    if character.velocity.y > 0:
        return "FallState"
    if character.is_on_floor():
        if abs(character.velocity.x) > 10:
            return "MoveState"
        else:
            return "IdleState"
    return ""