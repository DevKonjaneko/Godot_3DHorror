extends Node3D #hand v1.0

@onready var flashlight: SpotLight3D = $SpotLight3D
@export var battery: float = 25.0
@export var battery_drain_rate: float = 2.5
var is_on: bool = false

@export var battery_bar_path: NodePath
@onready var battery_bar: ProgressBar = get_node(battery_bar_path)

func _ready() -> void:
	if flashlight:
		flashlight.visible = is_on
	if battery_bar:
		battery_bar.max_value = 100
		battery_bar.value = battery

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Flashlight"):
		toggle_flashlight()
		
	if is_on and battery > 0:
		battery -= battery_drain_rate * delta

		if battery_bar:
			battery_bar.value = battery
		
		if battery <= 0:
			battery = 0 
			is_on = false
			if flashlight:
				flashlight.visible = false
			if battery_bar:
				battery_bar.value = 0
			print("Battery is dead!")

func toggle_flashlight() -> void:
	if not is_on and battery > 0:
		is_on = true
	else:
		is_on = false
	if flashlight:
		flashlight.visible = is_on

func recharge_battery(amount: float):
	battery += amount
	if battery > 100:
		battery = 100 # ไม่ให้แบตเกิน 100
	if battery:
		battery_bar.value = battery #อัพเดต UI battery
	print("Battery recharge")
