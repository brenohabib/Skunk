extends State

func enter_state() -> void:
    print("JumpState: Entrando no estado")

func physics_process_state(_delta: float) -> void:
    if character.direction:
        sprite.flip_h = character.direction > 0

func check_transitions() -> String:
    # Verificar transições existentes
    if character.is_on_floor() and character.velocity.x > 0:
        return "MoveState"
    if character.is_on_floor():
        return "IdleState"
    return ""