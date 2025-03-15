extends Node
class_name StateMachine

# Sinais para facilitar debugging
signal state_changed(state_name: String)

# Variáveis de estado
@export
var current_state: State
var states: Dictionary = {}
var previous_state: State

func _ready() -> void:
	# Inicializa os estados
	_initialize_states()
	
	# Define o estado inicial
	if states.has("IdleState"):
		change_state("IdleState")

func _initialize_states() -> void:
	# Adiciona todos os estados filhos ao dicionário
	for child in get_children():
		if child is State:
			var state = child as State
			states[state.name] = state

func _process(delta: float) -> void:
	if current_state:
		current_state.process_state(delta)
		
		# Verificar transições de estado
		current_state.check_transitions()

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_process_state(delta)

func _input(event: InputEvent) -> void:
	if current_state:
		current_state.input_state(event)

func change_state(state_name: String) -> void:
	if !states.has(state_name):
		push_error("Estado '" + state_name + "' não existe na máquina de estados")
		return
	
	if current_state:
		previous_state = current_state
		current_state.exit_state()
	
	current_state = states[state_name]
	current_state.enter_state()
	
	# Emite o sinal para debugging
	state_changed.emit()