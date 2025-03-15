extends State

func enter_state() -> void:
    sprite.play("Idle")
    print("IdleState: Entrando no estado")

func physics_process_state(_delta: float) -> void:
    character.velocity.x = move_toward(character.velocity.x, character.direction * character.SPEED, character.ACELERATION)

# Verificar transições existentes
func check_transitions() -> String:
    if Input.get_axis("ui_left", "ui_right") != 0:
        return "MoveState"
    if Input.is_action_just_pressed("ui_accept") and character.is_on_floor():
        return "JumpState"
    return ""