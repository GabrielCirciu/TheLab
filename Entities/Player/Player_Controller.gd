extends CharacterBody3D

signal prompt_changed(prompt: String)

@onready var ray: RayCast3D = $Camera3D/RayCast3D
var current: Interactable
var last_prompt := ""

func _ready() -> void:
	ray.add_exception(self)

func _physics_process(_delta: float) -> void:
	var target: Interactable = null
	if ray.is_colliding():
		target = ray.get_collider() as Interactable

	if target != current:
		if is_instance_valid(current):
			current.unfocus()
		current = target
		if current:
			current.focus()

	var prompt := current.prompt_text if is_instance_valid(current) else ""
	if prompt != last_prompt:
		last_prompt = prompt
		prompt_changed.emit(prompt)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_instance_valid(current):
		current.interact(self)
