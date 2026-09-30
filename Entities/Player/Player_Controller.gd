extends CharacterBody3D

@export var ray: RayCast3D

func _ready() -> void:
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

func _physics_process(_delta: float) -> void:
	_check_for_interactable()

func _unhandled_input(input: InputEvent) -> void:
	if input.is_action_pressed("interact"):
		var _ray_cast_target : Interactable = PlayerStats.current_interactable
		if is_instance_valid(_ray_cast_target):
			_ray_cast_target.interact(self)
