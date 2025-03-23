extends CharacterBody2D
class_name Skunk

const SPEED = 140.0
const JUMP_VELOCITY = 340.0
const ACELERATION = 15.0
const FRICTION = 20.0
const AIR_FRICTION = 5.0

@export var red_glass: PointLight2D
@export var green_glass: PointLight2D
@export var blue_glass: PointLight2D

var has_red_glass: bool = false
var has_green_glass: bool = false
var has_blue_glass: bool = false

var current_glass = ""
var direction = 0
var available_glasses = []

func _ready():
    red_glass.visible = false
    green_glass.visible = false
    blue_glass.visible = false
    update_available_glasses()

func _process(_delta):
    set_collision_mask_value(2, true)
    
    if Input.is_action_just_pressed("switch_glasses") and available_glasses.size() > 0:
        switch_to_next_glass()

# Atualiza a lista de óculos disponíveis com base nas flags
func update_available_glasses():
    available_glasses.clear()
    
    if has_red_glass:
        available_glasses.append("red")
    if has_green_glass:
        available_glasses.append("green")
    if has_blue_glass:
        available_glasses.append("blue")
        
    # Se não tinha nenhum óculos atual mas agora tem algum disponível
    if current_glass == "" and available_glasses.size() > 0:
        equip_glass(available_glasses[0])

# Alterna para o próximo óculos disponível na lista
func switch_to_next_glass():
    if available_glasses.size() <= 1:
        return
    
    var current_index = available_glasses.find(current_glass)
    
    # Calcula o próximo índice
    var next_index = (current_index + 1) % available_glasses.size()
    equip_glass(available_glasses[next_index])

# Equipa um óculos específico
func equip_glass(glass_type):
    red_glass.visible = false
    green_glass.visible = false
    blue_glass.visible = false
    
    match glass_type:
        "red":
            red_glass.visible = true
            current_glass = "red"
            Musics.set_music_rock()
        "green":
            green_glass.visible = true
            current_glass = "green"
            Musics.set_music_piano()
        "blue":
            blue_glass.visible = true
            current_glass = "blue"
            Musics.set_music_bossa()

func acquire_glass(glass_type):
    match glass_type:
        "red":
            has_red_glass = true
            Musics.set_music_rock()
        "green":
            has_green_glass = true
            Musics.set_music_piano()
        "blue":
            has_blue_glass = true
            Musics.set_music_bossa()
    
    update_available_glasses()
    
    # Se for o primeiro óculos adquirido, equipa-o automaticamente
    if current_glass == "":
        equip_glass(glass_type)