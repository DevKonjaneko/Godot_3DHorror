extends RayCast3D
#@onready var crosshair = get_parent().get_parent().get_node("player_ui/PlayerUI/VBoxContainer/crosshair")
@onready var interaction_label = get_parent().get_parent().get_node("player_ui/PlayerUI/VBoxContainer/interaction_label")

func _ready():
	interaction_label.hide()

func _physics_process(_delta: float) -> void:

	if is_colliding():	#เช็คว่า RayCast ชนอะไรอยู่หรือไม่
		var hit = get_collider()
		#Door
		if hit.name == "door_static":
			var door_script = hit.get_parent().get_parent().get_parent()
			var text = door_script.get_interaction_text()
			interaction_label.text = "[E] " + text
			interaction_label.show()
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().get_parent().get_parent().toggle_door()
		
		#Washing_Machine
		elif hit.name == "washing_machine":
			interaction_label.text = "[E] Open Door"
			interaction_label.show()
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().get_parent().get_parent().toggle_door()
		
		#Gardengate
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
		
		#Light_Switch
		elif hit.name == "light_switch":
			interaction_label.text = "[E] Interact"
			interaction_label.show()
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().toggle_light()
		
		#Door_bell
		elif hit.name == "door_bell":
			interaction_label.text = "[E] Interact"
			interaction_label.show()
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().ring_bell()
		
		#Washbasin_Drawer
		elif hit.name == "Washbasin_drawer_upper":
			var d_script = hit.get_parent().get_parent()
			var text = d_script.get_drawer_upper_text()
			interaction_label.text = "[E] " + text
			interaction_label.show()
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().get_parent().toggle_drawer_upper()
		elif hit.name == "Washbasin_drawer_lower":
			var d_script = hit.get_parent().get_parent()
			var text = d_script.get_drawer_upper_text()
			interaction_label.text = "[E] " + text
			interaction_label.show()
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().get_parent().toggle_drawer_lower()
		
		elif hit.name == "Note":
			interaction_label.text = "[E] Read"
			interaction_label.show()
			if Input.is_action_just_pressed("Interact"):
				hit.interact()
				print("Read Note")
			
		else: #ถ้าชนกับของอื่น → ให้ซ่อน Label
			interaction_label.hide()
			
	else: #ถ้าไม่ได้ชนอะไรเลย → ให้ซ่อน Label
		interaction_label.hide()
		
