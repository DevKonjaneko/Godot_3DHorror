extends Resource #ItemData v1.0
class_name ItemData

#Test
enum Itemtype {
	None,
	CONSUMABLE,
	KEY_ITEM
}
@export var Type : Itemtype = Itemtype.None
@export var Consumable_value: float = 0.0 # "recharge_battery" = 50
@export var Item_Effect: String = "" # "recharge_battery"

#===
@export var ItemName : String
@export var Icon : Texture2D
@export var ItemModelPrefab : PackedScene
