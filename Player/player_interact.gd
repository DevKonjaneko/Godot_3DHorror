extends RayCast3D
@onready var interaction_label = get_parent().get_parent().get_node("player_ui/PlayerUI/VBoxContainer/interaction_label")
@export var pc_ui: PCLoginScreen

func _ready():
	interaction_label.hide()

func _physics_process(_delta: float) -> void:
	if is_colliding():
		var hit = get_collider()
		if IsPickupableItem(hit):
			HandlePickupItem(hit)
		else:
			HandleInteractObject(hit)
	else:
		interaction_label.hide()  # ← แก้ไข: interaction_label() → interaction_label.hide()

#func _input(event: InputEvent):
	#if event.is_action_pressed("ui_cancel") and pc_ui and pc_ui.visible:
		#pc_ui.hide_ui()
			
func IsPickupableItem(hit: Node3D) -> bool:
	return hit.name == "Battery"

func HandlePickupItem(hit: Node3D) -> void:
	if is_colliding():	#เช็คว่า RayCast ชนอะไรอยู่หรือไม่
		if hit.name == "Battery":
			if global_position.distance_to(hit.global_position) <= 5.0:
				if hit.has_method("on_focus"):
					hit.on_focus()
				interaction_label.text = "[E] Pick-up"
				interaction_label.show()
				if Input.is_action_just_pressed("Interact"):
					# ส่ง Signal ไปให้ Inventory
					var interaction_area = get_parent().get_parent().get_node("InteractionArea")
					for item_data in interaction_area.ItemTypes:
						if item_data.ItemModelPrefab != null and item_data.ItemModelPrefab.resource_path == hit.scene_file_path:
							interaction_area.OnItemPickedUp.emit(item_data)
							hit.queue_free()
							print("Picked up: ", item_data.ItemName)
							return
					printerr("Item not found in ItemTypes")
			else:
				interaction_label.hide()
				
func HandleInteractObject(hit):
	if is_colliding():	#เช็คว่า RayCast ชนอะไรอยู่หรือไม่
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
			var text = d_script.get_right_door_text()
			interaction_label.text = "[E] " + text 
			interaction_label.show()
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().get_parent().toggle_right_door()
		elif hit.name == "garden_gate_l":
			var d_script = hit.get_parent().get_parent()
			var text = d_script.get_left_door_text()
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

		#Note
		elif hit.is_in_group("Note"): # ใช้ Group แทน Staticbody3D 
			interaction_label.text = "[E] Read"
			interaction_label.show()
			if Input.is_action_just_pressed("Interact"):
				hit.interact()
				print("Read Note")

		#Doorkey
		elif hit.name == "Door_key":
			if hit.has_method("on_focus"):
				hit.on_focus()
			interaction_label.text = "[E] Pick-up"
			interaction_label.show()
			if Input.is_action_just_pressed("Interact"):
				hit.interact()
				print("Key")
		#Pc
		elif hit.is_in_group("PC"):
			interaction_label.text = "[E] Interact"
			interaction_label.show()
			if Input.is_action_just_pressed("Interact"):
				print("Used Pc")
				if pc_ui:
					pc_ui.show_ui()
				
		elif hit.name == "Refrigerator_U_D":
			interaction_label.text = "[E] Interact"
			interaction_label.show()
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().get_parent().toggle_upper_door()
				print("Open")
		elif hit.name == "Refrigerator_L_D":
			interaction_label.text = "[E] Interact"
			interaction_label.show()
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().get_parent().toggle_lower_door()
				print("Open")
				
		elif hit.name == ("closet_door_l"):
			interaction_label.text = "[E] Interact"
			interaction_label.show()
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().get_parent().toggle_door_left()
				print("Open")
		elif hit.name == ("closet_door_r"):
			interaction_label.text = "[E] Interact"
			interaction_label.show()
			if Input.is_action_just_pressed("Interact"):
				hit.get_parent().get_parent().toggle_door_right()
				print("Open")
				
		else: #ถ้าชนกับของอื่น → ให้ซ่อน Label
			interaction_label.hide()

	else: #ถ้าไม่ได้ชนอะไรเลย → ให้ซ่อน Label
		interaction_label.hide()
