extends Node
class_name State

# Classe abstrata para os estados da state machine

func enter_state() -> void:
	pass

func exit_state() -> void:
	pass

func process_state(_delta: float) -> void:
	pass

func physics_process_state(_delta: float) -> void:
	pass

func input_state(_event: InputEvent) -> void:
	pass

func check_transitions() -> String:
	return ""