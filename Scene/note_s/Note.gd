extends StaticBody3D #Note v1.1
#res://Scene/note_s/Note.gd
#@export var albedo_texture: Texture2D

@export_multiline var note_text: String = "ใส่ข้อความของ Note ที่นี่"
@export var font_size: int = 24 #ปรับขนาดข้อความแต่ละแผ่น

@export_range(0, 3, 1) var correct_answer: int = 0

func _ready() -> void:
	pass

func interact():
	# หา Player และ note_ui
	var player = get_tree().current_scene.get_node("PlayerBody")
	var note_ui = player.get_node("player_ui/PlayerUI/note_ui")
	
	# แสดง Note UI พร้อมข้อความ
	note_ui.show_note(note_text, font_size)
	print("Note interact called!")
