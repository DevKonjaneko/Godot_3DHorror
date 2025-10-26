extends Node3D
#@onready var camera = $Camera3D

var sensitivity: float = 0.025

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent):
	
	if (event.is_action_pressed("Inventory")):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if (Input.mouse_mode == Input.MOUSE_MODE_VISIBLE) else Input.MOUSE_MODE_VISIBLE
		
	if event is InputEventMouseMotion:
		handle_camera_rotation(event)

func handle_camera_rotation(event: InputEventMouseMotion) -> void:
	get_parent().rotate_y(deg_to_rad(-event.relative.x * sensitivity))
	rotate_x(deg_to_rad(-event.relative.y * sensitivity))
	rotation.x = clamp(rotation.x, deg_to_rad(-75), deg_to_rad(75))
