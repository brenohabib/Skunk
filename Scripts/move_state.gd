extends State

func enter_state() -> void:
    print("MovingState: Entrando no estado")

func physics_process_state(_delta: float) -> void:
    character.direction = Input.get_axis("ui_left", "ui_right")
    if character.direction:
        character.velocity.x = move_toward(character.velocity.x, character.direction * character.SPEED, character.ACELERATION)
    character.move_and_slide()

    if character.direction:
        sprite.flip_h = character.direction > 0

# Verificar transições existentes
func check_transitions() -> String:
    if Input.get_axis("ui_left", "ui_right") == 0:
        return "IdleState"
    if Input.is_action_just_pressed("ui_accept") and character.is_on_floor():
        return "JumpState"
    return ""
