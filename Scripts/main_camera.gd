extends Camera2D

var screen_size := Vector2(1152 / zoom.x, 648 / zoom.y)
var cur_screen := Vector2( 0, 0 )

func _ready():
	top_level = true
	global_position = get_parent().global_position
	_update_screen( cur_screen )

func _physics_process(delta):
	var parent_screen : Vector2 = ( get_parent().global_position / screen_size ).floor()
	if not parent_screen.is_equal_approx( cur_screen ):
		_update_screen( parent_screen )


func _update_screen( new_screen : Vector2 ):
	cur_screen = new_screen
	global_position = cur_screen * screen_size + screen_size * 0.5
