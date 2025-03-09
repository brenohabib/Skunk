extends Control

@onready var resolution_drop_button: MenuButton = %ResolutionDropButton
@onready var fps_count: VBoxContainer = %FPSCount
@onready var vsync_drop_button: MenuButton = %VSyncDropButton

# Constantes para opções de configuração
const RESOLUTION_OPTIONS = {
	"1x": 1.0,
	"0.75x": 0.75,
	"0.5x": 0.5,
	"0.25x": 0.25
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
	fps_count.get_child(1).text = "60"
	fps_count.get_child(0).value = 0
	fps_count.get_child(0).connect("value_changed", _on_fps_changed)
	
	# Conectar sinais dos menus
	resolution_drop_button.get_popup().connect("id_pressed", _on_resolution_selected)
	vsync_drop_button.get_popup().connect("id_pressed", _on_vsync_selected)

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

func _on_fps_changed(value: int) -> void:
	if value == 100:
		Engine.max_fps = 0
		fps_count.get_child(1).text = "Unlimited"
		return
	fps_count.get_child(1).text = str(value + 60)
	Engine.max_fps = value + 60
