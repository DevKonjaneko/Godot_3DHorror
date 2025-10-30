extends Node3D
var d_r_opened = false
var d_l_opened = false
@export var d_r_locked = false
@export var d_l_locked = false

#Left_Door
func toggle_left_door():
	if d_l_locked:
		print("Left Locked")
		return
	if $AnimationPlayer.is_playing():
		return
	d_l_opened = !d_l_opened
	if d_l_opened:
		$AnimationPlayer.play("door_left_open")
	else:
		$AnimationPlayer.play_backwards("door_left_open")
#Right_Door
func toggle_right_door():
	if d_r_locked:
		print("Right Locked")
		return
	if $AnimationPlayer.is_playing():
		return
	d_r_opened = !d_r_opened
	if d_r_opened:
		$AnimationPlayer.play("door_right_open")
	else:
		$AnimationPlayer.play_backwards("door_right_open")

#Label 
func get_left_door_text() -> String:
	if d_l_locked:
		return "Locked"
	if d_l_opened:
		return "Close Door"
	return "Open Door"
func get_right_door_text() -> String:
	if d_r_locked:
		return "Locked"
	if d_r_opened:
		return "Close Door"
	return "Open Door"
