extends Node3D #door_bell v1.0
#res://Scene/interact_s/door_bell.gd
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
		if time_rung >= 2:
			get_tree().call_group("task_manager", "set_task", null, "Enter The House")
			print("เข้าไปภายในบ้าน")
			door.locked = false
		#if time_rung == 3:
			#get_tree().call_group("task_manager", "set_task", null, "Get the F**k Off")
			#door.locked = true
		#if time_rung == 4:
			#get_tree().call_group("task_manager", "set_task", null, "Mother F**kr")
			#door.locked = true
			#time_rung = 0
	else:
		print("Doorbell is already ringing!")
