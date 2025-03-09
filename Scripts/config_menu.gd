extends Control

@onready var resolution_drop_button: MenuButton = %ResolutionDropButton
@onready var fps_slider: HSlider = %FPSCount.get_child(0)
@onready var fps_label: Label = %FPSCount.get_child(1)
@onready var vsync_drop_button: MenuButton = %VSyncDropButton
@onready var show_fps_checkbox: CheckBox = %ShowFPSCheckBox

@onready var master_audio_label: Label = %MasterAudioVBox.get_child(1)
@onready var master_audio_slider: HSlider = %MasterAudioVBox.get_child(0)

# Constantes para opções de configuração
const RESOLUTION_OPTIONS = {
	"1x": 1.0,
	"0.75x": 0.75,
	"0.5x": 0.5,
}

const VSYNC_OPTIONS = {
	"Disabled": DisplayServer.VSYNC_DISABLED,
	"Enabled": DisplayServer.VSYNC_ENABLED,
	"Adaptive": DisplayServer.VSYNC_ADAPTIVE,
}

func _ready() -> void:
	# Iniciação
	_setup_resolution_menu()
	_setup_vsync_menu()
	
	# Valores padrão
	resolution_drop_button.text = "1x"
	vsync_drop_button.text = "Enabled"
	
	# Configuração do FPS
	fps_label.text = "60"
	fps_slider.value = 0
	fps_slider.connect("value_changed", _on_fps_changed)

	# Configuração de audio
	master_audio_slider.value = 100
	master_audio_label.text = str(master_audio_slider.value)
	master_audio_slider.connect("value_changed", _on_master_audio_changed)

	# Conectar sinais dos menus
	resolution_drop_button.get_popup().connect("id_pressed", _on_resolution_selected)
	vsync_drop_button.get_popup().connect("id_pressed", _on_vsync_selected)
	show_fps_checkbox.connect("toggled", _on_show_fps_toggled)

# Função genéria para configurar um popup menu
func _setup_menu(menu_button: MenuButton, options: Dictionary) -> void:
	var popup = menu_button.get_popup()
	popup.clear()
	
	var index = 0
	for key in options.keys():
		popup.add_item(key, index)
		index += 1

func _setup_resolution_menu() -> void:
	_setup_menu(resolution_drop_button, RESOLUTION_OPTIONS)

func _setup_vsync_menu() -> void:
	_setup_menu(vsync_drop_button, VSYNC_OPTIONS)

# Funções de resposta aos eventos de seleção
func _on_resolution_selected(id: int) -> void:
	var popup = resolution_drop_button.get_popup()
	var selected_text = popup.get_item_text(id)
	resolution_drop_button.text = selected_text
	
	var scale_factor = RESOLUTION_OPTIONS[selected_text]
	_apply_resolution_scale(scale_factor)

func _on_vsync_selected(id: int) -> void:
	var popup = vsync_drop_button.get_popup()
	var selected_text = popup.get_item_text(id)
	vsync_drop_button.text = selected_text
	
	var vsync_mode = VSYNC_OPTIONS[selected_text]
	_apply_vsync_mode(vsync_mode)

# Funções de aplicação das configurações
func _apply_resolution_scale(scale_factor: float) -> void:
	get_tree().root.content_scale_factor = 1.0 / scale_factor

func _apply_vsync_mode(mode: int) -> void:
	# Configurar o modo de vsync
	DisplayServer.window_set_vsync_mode(mode)

# Função para alterar o limite de FPS
func _on_fps_changed(value: int) -> void:
	if value == 100:
		Engine.max_fps = 0
		fps_label.text = "Unlimited"
		return
	fps_label.text = str(value + 60)
	Engine.max_fps = value + 60

# Função para mostrar ou esconder o contador de FPS
func _on_show_fps_toggled(active: bool) -> void:
	FpsCounter.visible = active

# Função para alterar o volume do audio
func _on_master_audio_changed(value: int) -> void:
	master_audio_label.text = str(value)
	var volume_db = linear_to_db(value / 100.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume_db)