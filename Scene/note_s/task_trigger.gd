extends Area3D #task_trigger
#res://Scene/note_s/task_trigger.gd

@onready var ui = get_tree().current_scene.get_node("PlayerBody/player_ui/PlayerUI/task_ui")
@export var task_text: String
var triggered = false

func _ready():
	body_entered.connect(enter_trigger)
	print("Task Trigger Ready")

func  enter_trigger(body):
	if body.name == "PlayerBody" and !triggered:
		triggered = true
		ui.set_task(body, task_text)
		print("Task Update")
