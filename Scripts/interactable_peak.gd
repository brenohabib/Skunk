extends Area2D

@export var interact_menu: CanvasLayer
@export var dialogue_container: PanelContainer
@export var dialogue: Label
@export var skunk: Skunk

var dialogue_peak = [
    "How lucky! You're black and white",
    "Maybe that's why you're moving around...",
    "Probably you can't understand why everything is like this",
    "Let me tell you some weird history",
    "A powerful mage blocked every color with his curse",
    "He was...",
    "A guardian of balance, once revered, now forgotten",
    "They say he feared the colors and what they could awaken",
    "So he sealed them away, leaving only shadows and light",
    "But something is changing... I can feel it",
    "Maybe you are the crack in his perfect prison"
]


var current_dialogue_index = 0
var is_dialogue_active = false
var is_inside_area = false

func _on_body_exited(_body:Node2D) -> void:
	interact_menu.hide()
	dialogue_container.hide()
	is_dialogue_active = false
	is_inside_area = false

func _on_body_entered(_body:Node2D) -> void:
	is_inside_area = true
	interact_menu.show()

func _input(_event: InputEvent) -> void:
	if is_inside_area and Input.is_action_just_pressed("interact") and !is_dialogue_active:
		interact_menu.hide()
		dialogue_container.show()
		is_dialogue_active = true
		current_dialogue_index = 0
		show_dialogue_line()
	
	# Avançar diálogo quando E é pressionado e o diálogo está ativo
	elif is_dialogue_active and Input.is_action_just_pressed("interact"):
		advance_dialogue()

func show_dialogue_line() -> void:
	if current_dialogue_index < dialogue_peak.size():
		dialogue.text = dialogue_peak[current_dialogue_index] + "[E]"
	else:
		end_dialogue()

func advance_dialogue() -> void:
	current_dialogue_index += 1
	
	# Verificar se ainda há mais linhas
	if current_dialogue_index < dialogue_peak.size():
		show_dialogue_line()
	else:
		self.set_collision_mask_value(1, false)
		end_dialogue()

func end_dialogue() -> void:
	dialogue_container.hide()
	is_dialogue_active = false
