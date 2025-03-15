# Estado Base (State.gd)
extends Node
class_name State

var state_machine: StateMachine
var character: CharacterBody2D
var sprite: AnimatedSprite2D

# Pega referência do player e seu sprite
func _ready() -> void:
    self.character = get_node("../..")
    self.sprite = character.get_node("AnimatedSprite2D")

func enter_state() -> void:
    pass

func exit_state() -> void:
    pass

func process_state(_delta: float) -> void:
    pass

# Método comum para processar a movimentação horizontal
func process_horizontal_movement(air_control := false) -> void:
    character.direction = Input.get_axis("ui_left", "ui_right")
    
    if character.direction:
        # No chão: aceleração normal
        if character.is_on_floor() or air_control:
            character.velocity.x = move_toward(
                character.velocity.x, 
                character.direction * character.SPEED, 
                character.ACELERATION
            )
    else:
        # Desaceleração
        var friction = character.FRICTION if character.is_on_floor() else character.AIR_FRICTION
        character.velocity.x = move_toward(character.velocity.x, 0, friction)
    
    # Atualiza a orientação do sprite
    if character.direction != 0:
        sprite.flip_h = character.direction > 0

# Método comum para aplicar gravidade
func apply_gravity(delta: float) -> void:
    character.velocity.y += (character.get_gravity().y) * delta

func physics_process_state(_delta: float) -> void:
    pass

func input_state(_event: InputEvent) -> void:
    pass

func check_transitions() -> String:
    return ""