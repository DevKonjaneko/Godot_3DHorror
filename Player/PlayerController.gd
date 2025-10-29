extends CharacterBody3D
#Health
@export var health: float = 30.0
@export var max_health: float = 100.0
#Movement
@export var speed: float = 2.50
@export var sprint_speed: float = 4.75
@export var jump_velocity: float = 4.50
#SoundEffect
@onready var heartbeat: AudioStreamPlayer = $Heartbeat
@onready var footstep_walk = $Footstep_Walk
@onready var footstep_sprint= $Footstep_Sprint
#Crouching
var is_crouching = false
#⭐Heartbeat
var is_heartbeat = false

func _ready() -> void:
	# Lock and Hide Cursor
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _process(_delta: float) -> void:
	#⭐ อัปเดตเสียงหัวใจทุกเฟรม
	update_heartbeat()
	
	if Input.is_action_just_pressed("Crouch"):
		is_crouching = !is_crouching
		print("is_crouch == true")
		
func handle_crouching(_delta: float) -> void:
	if is_crouching and $CollisionShape3D.shape.height > 0.2:
		var crouch_height = lerp($CollisionShape3D.shape.height, 0.2, 0.2) 
		$CollisionShape3D.shape.height = crouch_height
		
	if !is_crouching and $CollisionShape3D.shape.height < 2.0:
		var crouch_height = lerp($CollisionShape3D.shape.height, 2.0, 0.2)
		$CollisionShape3D.shape.height = crouch_height
	
func _physics_process(delta: float) -> void:
	#เช็ค Pause ก่อนทำอะไร!
	if (Input.mouse_mode == Input.MOUSE_MODE_VISIBLE):
		return
	handle_crouching(delta)
	handle_movement(delta)
	handle_gravity(delta)
	move_and_slide()

func handle_movement(delta):
	var current_speed = speed
	
	var is_sprinting = Input.is_action_pressed("Sprint")
	if is_sprinting:
		current_speed = sprint_speed
		
	var input_dir := Input.get_vector("M_Left", "M_Right", "M_Forward", "M_Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		
	#Footstep Logic
	if direction and is_on_floor():
		if is_sprinting:
			if not footstep_sprint.playing:
				footstep_sprint.play()
			footstep_walk.stop()
		else:
			if not footstep_walk.playing:
				footstep_walk.play()
			footstep_sprint.stop()
	else:
		footstep_walk.stop()
		footstep_sprint.stop()

func handle_gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity
		
func update_heartbeat() -> void:
	if not heartbeat or not heartbeat.stream:
		return
		
	# คำนวณ % HP
	var health_percent = (health / max_health) * 100.0
	
	# ⭐ กรณีที่ 1: HP น้อยกว่า 30% → เสียงหัวใจเต้นเร็ว
	if health_percent < 30.0:
		if not is_heartbeat:
			heartbeat.play()
			is_heartbeat = true
		# เล่นเร็วขึ้นเมื่อ HP ต่ำมาก
		heartbeat.pitch_scale = 1.5 if health_percent < 15.0 else 1.2
		heartbeat.volume_db = -10.0  # เสียงดังขึ้น
		
	# ⭐ กรณีที่ 2: HP ระหว่าง 30-50% → เสียงหัวใจเต้นช้า
	elif health_percent < 50.0:
		if not is_heartbeat:
			heartbeat.play()
			is_heartbeat = true
		heartbeat.pitch_scale = 1.0
		heartbeat.volume_db = -15.0  # เสียงเบาลง
		
	# ⭐ กรณีที่ 3: HP มากกว่า 50% → ปิดเสียง
	else:
		if is_heartbeat:
			heartbeat.stop()
			is_heartbeat = false
	
	# ⭐ ฟังก์ชันรักษา (ใหม่!)

#⭐Healsystem
func heal(amount: float) -> void:
	health += amount
	health = clamp(health, 0.0, max_health)
	print("💚 HP: ", health, "/", max_health)

#⭐Died
func player_died() -> void:
	print("💀 Player Died!")
	# หยุดเสียงหัวใจ
	if heartbeat:
		heartbeat.stop()
	# เพิ่มโค้ดตายที่นี่
