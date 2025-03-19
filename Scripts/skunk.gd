extends CharacterBody2D

const SPEED = 140.0
const JUMP_VELOCITY = 340.0
const ACELERATION = 15.0
const FRICTION = 20.0
const AIR_FRICTION = 5.0

@export var red_glass: PointLight2D
@export var green_glass: PointLight2D
@export var blue_glass: PointLight2D

var current_glass = "red"
var direction = 0

func _process(_delta):
    if Input.is_action_just_pressed("switch_glasses"):
        match current_glass:
            "red":
                red_glass.visible = false
                green_glass.visible = true
                current_glass = "green"
            "green":
                green_glass.visible = false
                blue_glass.visible = true
                current_glass = "blue"
            "blue":
                blue_glass.visible = false
                red_glass.visible = true
                current_glass = "red"

# func _physics_process(delta: float) -> void:

# 	if not is_on_floor():
# 		velocity += get_gravity() * delta

# 	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
# 		velocity.y = JUMP_VELOCITY

# 	direction = Input.get_axis("ui_left", "ui_right")
# 	if direction:
# 		velocity.x = direction * SPEED
# 	else:
# 		velocity.x = move_toward(velocity.x, 0, SPEED)

# 	move_and_slide()
