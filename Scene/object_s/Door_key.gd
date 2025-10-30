extends RigidBody3D #InteractableItem v1.0 - Base Class
class_name InteractableKey
@export var ItemHighlightMesh : MeshInstance3D
@export var ItemName: String = "Item"
@export_enum("Pickup", "Read", "Open", "Examine")
var interaction_type: String = "Pickup"

func GainFocus():
	ItemHighlightMesh.visible = true
		
func interact():
	print("Item Name = ", ItemName)
	queue_free()
