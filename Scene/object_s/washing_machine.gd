extends Node3D

var opened = false
var locked = false

func toggle_door():
	#ตรวจสอบว่าประตูล็อคหรือไม่
	if locked:
		print("DoorLocked")
		return
	# ตรวจสอบว่า Animation กำลังเล่นอยู่หรือไม่
	if $AnimationPlayer.is_playing():
		return
	opened = !opened
	if opened:
		$AnimationPlayer.play("door_open")
	else:
		$AnimationPlayer.play_backwards("door_open")
