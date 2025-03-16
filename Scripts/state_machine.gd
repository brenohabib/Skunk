# State Machine (StateMachine.gd)
extends Node
class_name StateMachine

var current_state: State
var states: Dictionary = {}

func _ready() -> void:
    # Registre todos os estados
    for child in get_children():
        if child is State:
            states[child.name] = child
            child.state_machine = self
    
    # Inicie com o estado padrão
    if states.has("IdleState"):
        change_state("IdleState")

func change_state(new_state_name: String) -> void:
    if current_state:
        current_state.exit_state()
    
    if states.has(new_state_name):
        current_state = states[new_state_name]
        current_state.enter_state()
    else:
        push_error("Estado não encontrado: " + new_state_name)

func _process(delta: float) -> void:
    if current_state:
        current_state.process_state(delta)
        
    # Verificar transições
        var new_state = current_state.check_transitions()
        if new_state != "":
            change_state(new_state)

func _physics_process(delta: float) -> void:
    if current_state:
        current_state.physics_process_state(delta)

func _input(event: InputEvent) -> void:
    if current_state:
        current_state.input_state(event)
