extends CharacterBody3D

signal prompt_changed(prompt: String)

@onready var ray: RayCast3D = $Camera3D/RayCast3D
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
			current_interactable.unfocus()
		current_interactable = target_of_raycast
		if current_interactable:
			current_interactable.focus()

	var prompt := current_interactable.prompt_text if is_instance_valid(current_interactable) else ""
	if prompt != last_prompt:
		last_prompt = prompt
		prompt_changed.emit(prompt)
		
func _ready() -> void:
	ray.add_exception(self)

func _physics_process(_delta: float) -> void:
	_check_for_interactable()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_instance_valid(current_interactable):
		current_interactable.interact(self)
