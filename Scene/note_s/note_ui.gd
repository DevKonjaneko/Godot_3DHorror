extends Control #note_ui v2.1

@onready var panel = $ColorRect/Panel
@onready var label = $ColorRect/Panel/Label
@onready var button = $ColorRect/Panel/Button

func _ready() -> void:
	hide()
	button.pressed.connect(_on_close_button_pressed)

func show_note(note_text: String, font_size: int = 24) -> void:
	label.text = note_text
	label.add_theme_font_size_override("font_size", font_size) # ⭐ ตั้งขนาดฟอนต์
	show()
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func _on_close_button_pressed() -> void:
	hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if visible and event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled() # ⭐ บล็อก Input ไม่ให้ส่งต่อ
		_on_close_button_pressed()
