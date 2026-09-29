extends CharacterBody3D

signal prompt_changed(prompt: String)

const SPEED = 5.0

@export var look_sensitivity: float = 0.0005

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var ray: RayCast3D = $Head/Camera3D/RayCast3D

var current_interactable: Interactable
var last_prompt := ""

func _check_for_interactable() -> void:
	# Shoots a raycast, expected at every physics step, checking for collision
	# On collision, if it hits a valid Interactable object, it fires a prompt change signal
	var target_of_raycast: Interactable = null
	if ray.is_colliding():
		target_of_raycast = ray.get_collider() as Interactable

	if target_of_raycast != current_interactable:
		if is_instance_valid(current_interactable):
			print("not interactable")
			current_interactable.unfocus()
		current_interactable = target_of_raycast
		if current_interactable:
			current_interactable.focus()

	var prompt := current_interactable.prompt_text if is_instance_valid(current_interactable) else ""
	if prompt != last_prompt:
		last_prompt = prompt
		prompt_changed.emit(prompt)
		
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	ray.add_exception(self)

func _physics_process(_delta: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	_check_for_interactable()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(-event.relative.x * look_sensitivity)
		camera.rotate_x(-event.relative.y * look_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(80))
	
	if Input.is_action_just_pressed("Escape"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if event is InputEventMouseButton and event.pressed:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
	if event.is_action_pressed("interact") and is_instance_valid(current_interactable):
		current_interactable.interact(self)
