extends Control

func _on_back_pressed():
	get_tree().change_scene_to_file("res://ui/mainmenu/mainmenu.tscn")

#option_button
func _on_resolution_button_item_selected(index: int):
	if index == 0:
		globalsetting.set_new_resolution(Vector2i(640, 480))
		get_window().size = Vector2i(640, 480)
		get_window().move_to_center()
	elif index == 1:
		globalsetting.set_new_resolution(Vector2i(1280, 720))
		get_window().size = Vector2i(1280, 720)
		get_window().move_to_center()
	elif index == 2:
		globalsetting.set_new_resolution(Vector2i(1920, 1080))
		get_window().size = Vector2i(1920, 1080)
		get_window().move_to_center()

#check_button
func _on_display_mode_checkbutton_toggled(is_fullscreen_on: bool):
	if is_fullscreen_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_vsync_check_button_toggled(is_vsync_on: bool):
	if is_vsync_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		print("Vsync = on")
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		print("Vsync = off")
