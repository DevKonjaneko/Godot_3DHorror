extends CanvasLayer

@onready var sub_viewport = $background/SubViewportContainer/SubViewport

func _ready():
	# แสดงเมาส์ในเมนู
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE #
	
	var current_res = globalsetting.current_resolution
	sub_viewport.size = Vector2(current_res.x, current_res.y)

func _input(event):
	if event is InputEventKey and event.is_pressed:
		get_tree().change_scene_to_file("res://ui/mainmenu/mainmenu.tscn")
		print("Titile_Screen by button")

func _on_press_any_key_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/mainmenu/mainmenu.tscn")
	print("Titile_Screen by press")
