extends Control

@onready var resolution_drop_button: MenuButton = %ResolutionDropButton
@onready var fps_count: VBoxContainer = %FPSCount

func _ready() -> void:
    _setup_resolution_menu()
    resolution_drop_button.text = "1x"
    fps_count.get_child(1).text = "60"
    fps_count.get_child(0).value = 0
    fps_count.get_child(0).connect("value_changed", _on_fps_changed)

    resolution_drop_button.get_popup().connect("id_pressed", _on_resolution_selected)


func _setup_resolution_menu() -> void:
    var popup = resolution_drop_button.get_popup()
    
    var options = get_screen_resolution_options()
    var index = 0
    for key in options.keys():
        popup.add_item(key, index)
        index += 1

func get_screen_resolution_options():
    var base_resolution = get_tree().root.size
    
    var resolution_options = {
        "1x": Vector2(base_resolution.x, base_resolution.y),
        "0.75x": Vector2(base_resolution.x * 0.75, base_resolution.y * 0.75),
    }
    
    return resolution_options

func _on_resolution_selected(id: int) -> void:
    var popup = resolution_drop_button.get_popup()
    var selected_text = popup.get_item_text(id)
    resolution_drop_button.text = selected_text
    
    var resolution_options = get_screen_resolution_options()
    var target_resolution = resolution_options[selected_text]

    get_tree().root.content_scale_factor = get_viewport().size.x / target_resolution.x

func _on_fps_changed(value: float) -> void:
    if value == 100:
        fps_count.get_child(1).text = "Unlimited"
        return
    fps_count.get_child(1).text = str(value + 60)