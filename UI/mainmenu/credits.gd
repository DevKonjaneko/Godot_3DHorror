extends Control

func _ready():
# แสดงเมาส์ในเมนู
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE #

func _on_back_pressed():
	get_tree().change_scene_to_file("res://ui/mainmenu/mainmenu.tscn")
