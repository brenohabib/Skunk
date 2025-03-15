extends State

func enter_state() -> void:
    print("MovingState: Entrando no estado")

func physics_process_state(_delta: float) -> void:
    pass

func check_transitions() -> String:
    # Verificar transições existentes
    if character.velocity.x == 0:
        return "IdleState"
    if !character.is_on_floor():
        return "JumpState"
    return ""