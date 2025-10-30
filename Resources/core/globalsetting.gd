extends Node #GlobalSettings

var current_resolution = Vector2i(1280, 720) #จดจำค่าResolution

func set_new_resolution(new_res: Vector2i):
	current_resolution = new_res #จำค่าใหม่
	get_window().size = current_resolution #เปลี่ยนขนาดหน้าต่าง
	get_window().move_to_center()
	
	print("GlobalSetting:", current_resolution)
