extends Node3D #Pc v1.0

var is_on = false # เปิด/ปิด PC
var is_interacting = false  # ป้องกันการกดซ้ำเร็วเกินไป

func _ready():
	print("PC ready")

func toggle_pc():
	is_on = !is_on
	if is_on:
		print("PC เปิดแล้ว!")
	else:
		print("PC ปิดแล้ว!")

func interact():
	if is_interacting:
		print("รอสักครู่...")
		return
	is_interacting = true
	print("กำลังโต้ตอบกับ PC...")
	toggle_pc()
	await get_tree().create_timer(0.5).timeout
	is_interacting = false
