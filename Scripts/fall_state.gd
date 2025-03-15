# Estado de Queda (FallState.gd)
extends State

func enter_state() -> void:
    # sprite.play("Fall")
    print("FallState: Entrando no estado")

func physics_process_state(delta: float) -> void:
    apply_gravity(delta * 1.7)
    process_horizontal_movement(true)  # true = controle aéreo
    character.move_and_slide()

func check_transitions() -> String:
    if character.is_on_floor():
        if abs(character.velocity.x) > 10:
            return "MoveState"
        else:
            return "IdleState"
    return ""