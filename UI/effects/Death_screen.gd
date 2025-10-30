extends Control #DeathScreen v1.0

@onready var respawn_button = $VBoxContainer/Respawn

func _ready() -> void:
	# Hide
	hide()
	
	# Connect
	if respawn_button:
		respawn_button.pressed.connect(_on_respawn_pressed)

#Respawn
func _on_respawn_pressed() -> void:
	print("🔄Respawning...")
	hide()
	hide_death_screen() # Call func
	get_tree().reload_current_scene()

#Hide Screen	
func hide_death_screen() -> void:
	hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	print("[Death Screen] hinding...")
