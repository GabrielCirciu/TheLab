extends Node3D

@onready var interactable: Interactable = $Interactable
var is_open := false

func _ready() -> void:
	interactable.interacted.connect(_on_interacted)
	_update_prompt()

func _on_interacted(_who: Node) -> void:
	is_open = not is_open
	_update_prompt()
	# play animation, tween rotation, etc.

func _update_prompt() -> void:
	if is_open:
		interactable.change_prompt_text("Close")
	else:
		interactable.change_prompt_text("Open")
