extends CanvasLayer #task_ui v1.0

func _ready() -> void:
	set_task(null, "ทดสอบระบบเควส")

func set_task(body, task_text: String):
	#if body == null || body != null and body.name == "PlayerBody":
		#$task_ui/DescriptionTextLabel.text = task_text
	$DescriptionTextLabel.text = task_text
