extends Area2D

@export var interact_menu: CanvasLayer
@export var dialogue_container: PanelContainer
@export var dialogue: Label
@export var skunk: Skunk

@export var fire_collisions: StaticBody2D
@export var mmmaha: Area2D

var dialogue_peak = [
	"I was watching you from afar...",
	"Impressive skills you've got on your pocket",
	"Why am I red like blood?",
	"I'm a demon!",
	"The laws of your world means nothing to me",
	"...",
	"......",
	"... Okay, okay",
	"Here is your red thing",
	"But I'll not let you keep it easly",
	"You may go back to the wisdom frog",
	"Give him all the chroma fragments",
	"He'll merge them all into a single one"
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
	if current_dialogue_index == 8:
		skunk.acquire_glass("red")
		skunk.equip_glass("red")
		Musics.set_music_rock()
		fire_collisions.set_collision_layer_value(1, true)
		mmmaha.monitoring = true

func end_dialogue() -> void:
	dialogue_container.hide()
	is_dialogue_active = false
