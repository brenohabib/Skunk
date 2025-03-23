extends Area2D

@export var interact_menu: CanvasLayer
@export var dialogue_container: PanelContainer
@export var dialogue: Label
@export var skunk: Skunk

var dialogue_lines = [
	"You may think I'm a tree...[E]",
	"Come closer and you may see...[E]",
	"Behold, one of the chroma fragments[E]",
	"You may see nature from now on[E]",
	"Please, restore the color back to our world![E]"
]

var current_dialogue_index = 0
var is_dialogue_active = false

func _on_body_exited(_body:Node2D) -> void:
	interact_menu.hide()
	dialogue_container.hide()
	is_dialogue_active = false

func _on_body_entered(_body:Node2D) -> void:
	interact_menu.show()

func _input(_event: InputEvent) -> void:
	if interact_menu.visible == true and Input.is_action_just_pressed("interact"):
		interact_menu.hide()
		dialogue_container.show()
		is_dialogue_active = true
		current_dialogue_index = 0
		show_dialogue_line()
	
	# Avançar diálogo quando E é pressionado e o diálogo está ativo
	elif is_dialogue_active and Input.is_action_just_pressed("interact"):
		advance_dialogue()

func show_dialogue_line() -> void:
	if current_dialogue_index < dialogue_lines.size():
		dialogue.text = dialogue_lines[current_dialogue_index]
	else:
		end_dialogue()

func advance_dialogue() -> void:
	current_dialogue_index += 1
	
	# Verificar se ainda há mais linhas
	if current_dialogue_index < dialogue_lines.size():
		show_dialogue_line()
	else:
		self.set_collision_mask_value(1, false)
		end_dialogue()
	
	if current_dialogue_index == 2:
		skunk.equip_glass("green")
		Musics.set_music_piano()

func end_dialogue() -> void:
	dialogue_container.hide()
	is_dialogue_active = false