extends StaticBody3D #InteractableItem v1.0 - Base Class
class_name InteractableKey

@export var outline : MeshInstance3D

# ชื่อที่แสดงบน UI
@export var display_name: String = "Item"

# ประเภทการโต้ตอบ
@export_enum("Pickup", "Read", "Open", "Examine")
var interaction_type: String = "Pickup"

func on_focus():# เมื่อเล็ง
	if outline:
		outline.visible = true

#func off_focus():# เมื่อไม่ได้เล็ง
	#if outline:
		#outline.visible = false
		
func interact():
	queue_free()
