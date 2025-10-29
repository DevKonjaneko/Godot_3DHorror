extends Control
class_name PCLoginScreen

func _ready():
	visible = false
	
func show_ui():
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func hide_ui():
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
