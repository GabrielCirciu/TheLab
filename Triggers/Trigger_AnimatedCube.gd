extends Node3D

@onready var interactable: Interactable = $Area3D
@onready var anim: AnimationPlayer = $AnimationPlayer

var is_used := false

func _ready() -> void:
	interactable.interacted.connect(_on_interacted)
	_update_prompt()

func _on_interacted(_who: Node) -> void:
	if anim.is_playing():
		return # ignore input mid-swing

	is_used = not is_used
	if is_used:
		anim.play("Cube_Bounce")
	else:
		anim.play_backwards("Cube_Bounce")
	_update_prompt()

func _update_prompt() -> void:
	interactable.prompt_text = "Downies" if is_used else "Uppies"
