extends CharacterBody3D

@export var ray: RayCast3D
@export var look_sensitivity: float = 0.0005

@onready var head = $Head
@onready var camera = $Head/Camera3D

const SPEED = 5.0

var current_interactable: Interactable
var sitting = false

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
		
func _movement_input() -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

func _physics_process(_delta: float) -> void:
	_movement_input()
	move_and_slide()
	_check_for_interactable()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(-event.relative.x * look_sensitivity)
		camera.rotate_x(-event.relative.y * look_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(80))
	
	if Input.is_action_just_pressed("escape"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if event is InputEventMouseButton and event.pressed:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
	if event.is_action_pressed("interact"):
		var _ray_cast_target : Interactable = PlayerStats.current_interactable
		if is_instance_valid(_ray_cast_target):
			_ray_cast_target.interact(self)

func sit(pos: Vector3) -> void:
	sitting = true
	global_position = pos
	
