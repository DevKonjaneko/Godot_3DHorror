extends Control #note_ui v2.1

@onready var panel = $ColorRect/Panel
@onready var label = $ColorRect/Panel/Label
@onready var button1 = $ColorRect/Panel/VBoxContainer/HBoxContainer/button1
@onready var button2 = $ColorRect/Panel/VBoxContainer/HBoxContainer/button2
@onready var button3 = $ColorRect/Panel/VBoxContainer/HBoxContainer/button3
@onready var button4 = $ColorRect/Panel/VBoxContainer/HBoxContainer/button4
@onready var button = $ColorRect/Panel/VBoxContainer/Back

var current_correct_answer: int = 0

func _ready() -> void:
	hide()
	button.pressed.connect(_on_close_button_pressed)
	print("Close_PC_SCREEN")
	button1.pressed.connect(_button_1_pressed)
	button2.pressed.connect(_button_2_pressed)
	button3.pressed.connect(_button_3_pressed)
	button4.pressed.connect(_button_4_pressed)
	
func show_note(note_text: String, font_size: int = 24, correct_answer: int = 0) -> void:
	current_correct_answer = correct_answer
	label.text = note_text
	label.add_theme_font_size_override("font_size", font_size)
	show()
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func _input(event):
	if visible and event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled() # ⭐ บล็อก Input ไม่ให้ส่งต่อ
		_on_close_button_pressed()

func _on_close_button_pressed() -> void:
	hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	print("Close_Note")

# Choose
func _button_1_pressed() -> void:
	check_answer(0)
	print("คุณเลือก: ตัวเลือกที่ 1")
func _button_2_pressed() -> void:
	check_answer(1)
	print("คุณเลือก: ตัวเลือกที่ 2")
func _button_3_pressed() -> void:
	check_answer(2)
	print("คุณเลือก: ตัวเลือกที่ 3")
func _button_4_pressed() -> void:
	check_answer(3)
	print("คุณเลือก: ตัวเลือกที่ 4")

# Check answer
func check_answer(selected_index: int) -> void:
	if selected_index == current_correct_answer:
		print("✅ Correct!")
	else:
		print("❌ Wrong!")
		# ⭐ ลด HP 10
		var player = get_tree().current_scene.get_node("PlayerBody")
		if player.has_method("take_damage"):
			player.take_damage(10)
