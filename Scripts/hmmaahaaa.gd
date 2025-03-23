extends Area2D

@export var interact_menu: CanvasLayer
@export var dialogue_container: PanelContainer
@export var dialogue: Label
@export var skunk: Skunk

@export var red: PointLight2D
@export var green: PointLight2D
@export var blue: PointLight2D

@export var timer: Timer
@export var vid: BoxContainer

var dialogue_lines = [
	"Oh... is these...",
	"It couldn't be",
	"Let me try this...",
	"Vuala!",
	"And now?"
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
	if current_dialogue_index < dialogue_lines.size():
		dialogue.text = dialogue_lines[current_dialogue_index] + "[E]"
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

	if current_dialogue_index == 3:
		red.show()
		green.show()
		blue.show()

func end_dialogue() -> void:
	dialogue_container.hide()
	is_dialogue_active = false
	timer.start()

func _on_timer_timeout() -> void:
	vid.show()
	vid.get_child(0).play()


func _on_video_stream_player_finished() -> void:
	get_tree().quit()