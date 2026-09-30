class_name Player
extends CharacterBody3D

@export var ray: RayCast3D
@export var look_sensitivity: float = 0.0005
@export var player_speed: float = 5.0

@onready var head = $Head
@onready var camera = $Head/Camera3D

var current_interactable: Interactable

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	ray.add_exception(self)

func _check_for_interactable() -> void:
	# Shoots a raycast, expected at every physics step, checking for collision
	# On collision, if it hits a valid Interactable object, it sets target to focused
	# and it saves what is being interacted with in the PlayerStats script
	var _ray_target: Interactable = null
	if ray.is_colliding():
		_ray_target = ray.get_collider() as Interactable
		
	if _ray_target != PlayerStats.current_interactable:
		if is_instance_valid(PlayerStats.current_interactable):
			PlayerStats.current_interactable.unfocus()
		PlayerStats.current_interactable = _ray_target
		if _ray_target:
			_ray_target.focus()

func teleport_to(pos: Vector3, yaw: float = NAN) -> void:
	global_position = pos
	velocity = Vector3.ZERO
	if not is_nan(yaw): # Necessary fix otherwise standing up will fuck us up
		head.global_rotation.y = yaw
		camera.rotation.x = 0.0
		
func _movement_input() -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * player_speed
		velocity.z = direction.z * player_speed
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
		velocity.z = move_toward(velocity.z, 0, player_speed)

func _physics_process(_delta: float) -> void:
	_movement_input()
	_check_for_interactable()
	if !PlayerStats.is_sitting:
		move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(-event.relative.x * look_sensitivity)
		camera.rotate_x(-event.relative.y * look_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(80))
	
	if Input.is_action_just_pressed("escape"):
		if PlayerStats.is_sitting:
			PlayerStats.current_chair.stand(self)
			get_viewport().set_input_as_handled()
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if event is InputEventMouseButton and event.pressed:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
	if event.is_action_pressed("interact"):
		var _ray_cast_target : Interactable = PlayerStats.current_interactable
		if is_instance_valid(_ray_cast_target):
			_ray_cast_target.interact(self)
