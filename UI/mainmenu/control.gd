extends Control

@export var crosshair_textures: Array[Texture2D]

func _ready():
	pass

func _on_back_pressed():
	get_tree().change_scene_to_file("res://ui/mainmenu/mainmenu.tscn")

func _on_h_slider_value_changed():
	pass 
