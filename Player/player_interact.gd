extends RayCast3D

#@onready var crosshair = get_parent().get_parent().get_node("player_ui/PlayerUI/VBoxContainer/crosshair")
@onready var interaction_label = get_parent().get_parent().get_node("player_ui/PlayerUI/VBoxContainer/interaction_label")

func _ready():
	interaction_label.hide()

func _physics_process(_delta: float) -> void:

	if is_colliding():	#เช็คว่า RayCast ชนอะไรอยู่หรือไม่
		var hit = get_collider()
		
		if hit.name == "door_static":
			# 1. หา Script ของประตู
			var door_script = hit.get_parent().get_parent().get_parent()
			# 2. เรียกใช้ function get_interaction_text()
			var text = door_script.get_interaction_text()
			# 3. แสดงข้อความนั้นบน Label
			interaction_label.text = "[E] " + text
			interaction_label.show()
			# 4. ถ้ากด E → เรียก toggle_door()
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().get_parent().get_parent().toggle_door()
	
		elif hit.name == "washing_machine":
			interaction_label.text = "[E] Open Door"
			interaction_label.show()
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().get_parent().get_parent().toggle_door()
				
		elif hit.name == "garden_gate_r":
			var d_script = hit.get_parent().get_parent()
			var text = d_script.get_left_door_text()
			interaction_label.text = "[E] " + text 
			interaction_label.show()
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().get_parent().toggle_right_door()
		elif hit.name == "garden_gate_l":
			var d_script = hit.get_parent().get_parent()
			var text = d_script.get_right_door_text()
			interaction_label.text = "[E] " + text
			interaction_label.show()
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().get_parent().toggle_left_door()
				
		elif hit.name == "light_switch":
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().toggle_light()
		
		elif hit.name == "door_bell":
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().ring_bell()
		
		else: #ถ้าชนกับของอื่น → ให้ซ่อน Label
			interaction_label.hide()
			
	else: #ถ้าไม่ได้ชนอะไรเลย → ให้ซ่อน Label
		interaction_label.hide()
		
