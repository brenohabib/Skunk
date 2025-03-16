extends CharacterBody2D

const SPEED = 170.0
const JUMP_VELOCITY = 350.0
const ACELERATION = 15.0
const FRICTION = 20.0
const AIR_FRICTION = 5.0

var direction = 0



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
