extends State

func enter_state() -> void:
    print("FallState: Entrando no estado")

func exit_state() -> void:
    pass

func physics_process_state(delta: float) -> void:
    character.velocity += character.get_gravity() * delta
    
    # Para permitir controle aéreo
    character.direction = Input.get_axis("ui_left", "ui_right")
    if character.direction:
        if character.velocity.x < character.SPEED and character.velocity.x > -character.SPEED:
            character.velocity.x += character.ACELERATION * character.direction
    else:
        # Desaceleração no ar
        character.velocity.x = move_toward(character.velocity.x, 0, character.AIR_FRICTION)
        
    character.move_and_slide()
    
    if character.direction:
        sprite.flip_h = character.direction > 0  # Ajuste conforme a orientação do sprite

func check_transitions() -> String:
    if character.is_on_floor():
        if Input.get_axis("ui_left", "ui_right") != 0:
            return "MoveState"
        else:
            return "IdleState"
    return ""
