extends Node3D

@onready var interactable: Interactable = $Area3D

var is_used := false


func _ready() -> void:
	interactable.interacted.connect(_on_interacted)
	_update_prompt()

func _on_interacted(_who: Node) -> void:
	if _who is CharacterBody3D:
		is_used = not is_used
		_who.sit(global_position)
	
	_update_prompt()

func _update_prompt() -> void:
	interactable.prompt_text = "" if is_used else "Sit"
