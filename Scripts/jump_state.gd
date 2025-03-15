extends State

func enter_state() -> void:
    print("JumpState: Entrando no estado")
    character.velocity.x = 0
    character.velocity.y = -character.JUMP_VELOCITY

func physics_process_state(delta: float) -> void:
    # Aplica gravidade
    character.velocity.y += character.get_gravity().y * delta
    
    # Controle horizontal durante o pulo
    character.direction = Input.get_axis("ui_left", "ui_right")
    if character.direction:
        if character.velocity.x < character.SPEED and character.velocity.x > -character.SPEED:
            character.velocity.x += character.ACELERATION * character.direction
    else:
        character.velocity.x = move_toward(character.velocity.x, 0, character.AIR_FRICTION)
    
    character.move_and_slide()
    
    if character.direction:
        sprite.flip_h = character.direction > 0

# Verificar transições existentes
func check_transitions() -> String:
    if character.velocity.y > 0:
        return "FallState"
    if character.is_on_floor():
        return "IdleState"
    return ""