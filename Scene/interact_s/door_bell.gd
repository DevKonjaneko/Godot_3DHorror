extends Node3D #door_bell v1.0
@export var door: Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var time_rung = 0  
@onready var sound_player: AudioStreamPlayer3D = $AntiqueDoorBellRing

func _ready() -> void:
	pass

func ring_bell():
	if not sound_player.is_playing():
		animation_player.play("press")
		sound_player.play()
		time_rung += 1
		print("Time Rung ", time_rung)
		if time_rung >= 4:
			get_tree().call_group("task_manager", "set_task", null, "Go the hell")
		if time_rung == 3:
			get_tree().call_group("task_manager", "set_task", null, "Get the fuck off")
		if time_rung == 2:
			get_tree().call_group("task_manager", "set_task", null, "Enter The House")
			print("เข้าไปภายในบ้าน")
			
	else:
		print("Doorbell is already ringing!")
