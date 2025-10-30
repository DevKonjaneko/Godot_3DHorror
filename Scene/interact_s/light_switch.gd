# res://.../light_switch.gd
extends Node3D
@export var is_on: bool = false

@export var light_bulb_node: Node 
@onready var switch_on_mesh: Node3D = $on
@onready var switch_off_mesh: Node3D = $off
@onready var sound_player: AudioStreamPlayer3D = $LightSwitch

func _ready() -> void:
	update_switch_visuals()
	if light_bulb_node and light_bulb_node.has_method("set_light_state"):
		light_bulb_node.set_light_state(is_on)

func toggle_light() -> void:
	#Playsound_effect
	sound_player.play()
	
	is_on = !is_on
	update_switch_visuals()
	
	if light_bulb_node and light_bulb_node.has_method("toggle_light"):
		light_bulb_node.toggle_light()
	else:
		print("ERROR: ยังไม่ได้กำหนด Light Bulb Node ใน Inspector ของสวิตช์!")

func update_switch_visuals() -> void:
	if is_on:
		switch_on_mesh.visible = true
		switch_off_mesh.visible = false
	else:
		switch_on_mesh.visible = false
		switch_off_mesh.visible = true
