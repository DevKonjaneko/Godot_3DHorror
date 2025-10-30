extends Node3D #Washbasin v1.0
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var drawer_upper_open: bool = false
var drawer_lower_open: bool = false

func toggle_drawer_upper():
	if animation_player.is_playing():
		return
	drawer_upper_open = !drawer_upper_open
	if drawer_upper_open:
		animation_player.play("drawer_upper_open")
		print("Drawer Upper: Opening")
	else:
		animation_player.play_backwards("drawer_upper_open")
		print("Drawer Upper: Closing")

func toggle_drawer_lower():
	if animation_player.is_playing():
		return
	drawer_lower_open = !drawer_lower_open
	if drawer_lower_open:
		animation_player.play("drawer_lower_open")
		print("Drawer Lower: Opening")
	else:
		animation_player.play_backwards("drawer_lower_open")
		print("Drawer Lower: Closing")

func get_drawer_upper_text() -> String:
	if drawer_upper_open:
		return "Close Upper Drawer"
	return "Open Upper Drawer"

func get_drawer_lower_text() -> String:
	if drawer_lower_open:
		return "Close Lower Drawer"
	return "Open Lower Drawer"
