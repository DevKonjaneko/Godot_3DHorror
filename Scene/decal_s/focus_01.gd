extends Node3D
@export var is_on: bool = true
@export var light_node: OmniLight3D
@export var mesh_node: MeshInstance3D
@export var material_on: StandardMaterial3D
@export var material_off: StandardMaterial3D
# ตัวแปรสำหรับควบคุมการกระพริบ
@export var flicker_enabled: bool = false
@export var min_flicker_time: float = 0.1
@export var max_flicker_time: float = 0.5
@onready var timer: Timer = $Timer
# Sound_Effect
@onready var buzz_sound: AudioStreamPlayer3D = $BUZZ_Fluorescent

func _ready() -> void:
	set_light_state(is_on) # ตั้งค่าสถานะเริ่มต้นของไฟเมื่อเริ่มฉาก
	
	if flicker_enabled: 	# ถ้าเปิดใช้งานการกระพริบให้เริ่มทำงาน
		start_flickering()
		
# ฟังก์ชันสำหรับเปิดหรือปิดไฟ
func set_light_state(state: bool) -> void:
	is_on = state 
	if light_node:
		light_node.visible = state
	# ตรวจสอบว่า mesh_node ถูกกำหนดค่าไว้หรือไม่
	if mesh_node:
		if state:
			mesh_node.set_surface_override_material(0, material_on)  #ถ้า state เป็น true (เปิดไฟ) ให้ใช้ material_on
		else:
			mesh_node.set_surface_override_material(0, material_off) #ถ้า state เป็น false (ปิดไฟ) ให้ใช้ material_off
	
	# Sound effect
	if buzz_sound:
		if state:
			#เปิดไฟ -> เล่นเสียง
			if not buzz_sound.playing:
				buzz_sound.play()
		else:
			# ปิดไฟ → หยุดเสียง
			buzz_sound.stop()

# ฟังก์ชันสำหรับสลับสถานะไฟ (เปิด/ปิด)
func toggle_light() -> void:
	set_light_state(!is_on)
	
# ฟังก์ชันเริ่มการกระพริบ
func start_flickering() -> void:
	# สุ่มเวลาแล้วเริ่มนับถอยหลัง
	timer.wait_time = randf_range(min_flicker_time, max_flicker_time)
	timer.start()

func _on_timer_timeout() -> void:
	# สลับสถานะไฟ (ถ้าเปิดอยู่ให้ปิด, ถ้าปิดอยู่ให้เปิด)
	toggle_light()
	# เริ่มการนับถอยหลังรอบใหม่
	start_flickering()
