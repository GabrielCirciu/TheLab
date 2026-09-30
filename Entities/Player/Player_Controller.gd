extends CharacterBody3D

@export var rayCast: RayCast3D

func _ready() -> void:
	rayCast.add_exception(self)

func _check_for_interactable() -> void:
	# Shoots a raycast, expected at every physics step, checking for collision
	# On collision, if it hits a valid Interactable object, it sets target to focused
	# and it saves what is being interacted with in the PlayerStats script
	var _rayCastTarget: Interactable = null
	if rayCast.is_colliding():
		_rayCastTarget = rayCast.get_collider() as Interactable

	if _rayCastTarget != PlayerStats.currentInteractable:
		if is_instance_valid(PlayerStats.currentInteractable):
			PlayerStats.currentInteractable.unfocus()
		PlayerStats.currentInteractable = _rayCastTarget
		if _rayCastTarget:
			_rayCastTarget.focus()

func _physics_process(_delta: float) -> void:
	_check_for_interactable()

func _unhandled_input(inputEvent: InputEvent) -> void:
	if inputEvent.is_action_pressed("interact"):
		var _rayCastTarget := PlayerStats.currentInteractable
		if is_instance_valid(_rayCastTarget):
			_rayCastTarget.interact(self)
