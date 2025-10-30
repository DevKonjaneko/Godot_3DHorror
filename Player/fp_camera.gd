extends Node3D
#@onready var camera = $Camera3D
var sensitivity: float = 0.016

#ตัวแปรที่เกี่ยวกับระบบซูมแบบ Toggle
var is_zoomed_in: bool = false #ตัวแปรช่วยจำสถานะการซูม เริ่มต้นคือยังไม่ซูม
@onready var camera = $Camera3D
@export var default_fov   = 75.0  #ค่า FOV ปกติ
@export var zoomed_in_fov = 35.0  #ค่า FOV ตอนซูม
@export var zoom_duration = 0.75  #ความเร็วในการซูม

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent):
	
	if (event.is_action_pressed("Inventory")):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if (Input.mouse_mode == Input.MOUSE_MODE_VISIBLE) else Input.MOUSE_MODE_VISIBLE
		
	if event is InputEventMouseMotion:
		handle_camera_rotation(event)
	
	if event.is_action_pressed("Zoom"):
		toggle_zoom()

func handle_camera_rotation(event: InputEventMouseMotion) -> void:
	get_parent().rotate_y(deg_to_rad(-event.relative.x * sensitivity))
	rotate_x(deg_to_rad(-event.relative.y * sensitivity))
	rotation.x = clamp(rotation.x, deg_to_rad(-75), deg_to_rad(75))

func toggle_zoom() -> void:
		is_zoomed_in = not is_zoomed_in
		if is_zoomed_in:
			tween_camera_fov(zoomed_in_fov)
		else:
			tween_camera_fov(default_fov)

func tween_camera_fov(target_fov):
	var tween = create_tween()
	tween.tween_property(camera, "fov", target_fov, zoom_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
