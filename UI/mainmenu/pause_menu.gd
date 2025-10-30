extends Control #pause_menu v1.0
#res://UI/mainmenu/pause_menu.gd

func  _ready():
	hide()
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = not get_tree().paused
		if get_tree().paused:
			show()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			hide()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_resume_pressed():
	get_tree().paused = false
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_options_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/mainmenu/options.tscn")

func _on_mainmenu_pressed():
	get_tree().paused = false 
	get_tree().change_scene_to_file("res://ui/mainmenu/title_screen.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_save_pressed() -> void:
	pass # Replace with function body.
