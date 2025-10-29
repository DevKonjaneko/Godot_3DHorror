extends Control #task_ui v1.0
#res://Scene/note_s/task_trigger.gd
func _ready() -> void:
	set_task(null, "เข้าไปในบ้าน")
	pass
func set_task(body, task_text: String):
	if body == null || body != null and body.name == "PlayerBody":
		#$task_ui/DescriptionTextLabel.text = task_text
		$DescriptionTextLabel.text = task_text
