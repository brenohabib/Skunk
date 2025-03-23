extends Area2D

@export var interact_menu: CanvasLayer
@export var dialogue_container: PanelContainer
@export var dialogue: Label
@export var skunk: Skunk

var dialogue_peak = [
    "I'm the greatesssssss ssword in the world!",
    "Wait... You can sssssee me?",
    "That means you're different... or maybe jussst broken enough to notice.",
    "No one elsse bothers with a talking ssssnake these days.",
    "Lisssten, traveler, the world is blind, drowned in black and white.",
    "But I have a gift... a key to what was losssst.",
    "Take thisss, litte gray creature",
    "Put it over your eye and you'll sssee what othersss cannot.",
	"Oh, before I forget",
	"You can change between lens pressing [TAB]"
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
	if current_dialogue_index == 6:
		skunk.acquire_glass("blue")
		skunk.equip_glass("blue")
		Musics.set_music_bossa()

func end_dialogue() -> void:
	dialogue_container.hide()
	is_dialogue_active = false
