extends State

func enter_state() -> void:
    print("MovingState: Entrando no estado")

func physics_process_state(delta: float) -> void:
    if not character.is_on_floor():
        character.velocity += character.get_gravity() * delta

    if Input.is_action_just_pressed("ui_accept") and character.is_on_floor():
        character.velocity.y = character.JUMP_VELOCITY

    character.direction = Input.get_axis("ui_left", "ui_right")
    if character.direction:
        character.velocity.x = character.direction * character.SPEED * delta
  
    character.move_and_slide()

    if character.direction:
        sprite.flip_h = character.direction > 0

func check_transitions() -> String:
    # Verificar transições existentes
    if character.velocity.x == 0:
        return "IdleState"
    if !character.is_on_floor():
        return "JumpState"
    return ""