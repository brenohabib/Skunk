extends Node
class_name State

# Classe abstrata para os estados da state machine

var state_machine: StateMachine
var character: CharacterBody2D
var sprite: AnimatedSprite2D

# Pega referência do player e seu sprite
func initialize(character_node: CharacterBody2D) -> void:
	self.character = character_node
	self.sprite = character.get_node("AnimatedSprite2D")

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
