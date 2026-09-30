class_name Interactable
extends Area3D

signal interacted(interactor: Node)

enum Kind { GENERIC, BUTTON, DOOR, CHAIR }

@export var kind: Kind = Kind.GENERIC
@export var prompt_text := "<NO PROMPT SET>"
@export var anim: AnimationPlayer = null

var is_open := false # only used by Kind.DOOR

func focus() -> void:
	InteractionPrompt.instance.show_prompt(prompt_text)

func unfocus() -> void:
	InteractionPrompt.instance.hide_prompt()

func interact(interactor: Node) -> void:
	interacted.emit(interactor)
	match kind:
		Kind.BUTTON:
			_press_button()
		Kind.DOOR:
			_toggle_door()
		Kind.CHAIR:
			_sit_chair()
		_:
			pass
	InteractionPrompt.instance.show_prompt(prompt_text)

func _press_button() -> void:
	if anim:
		anim.play("press")

func _toggle_door() -> void:
	is_open = not is_open
	prompt_text = "Close" if is_open else "Open"
	if anim:
		if is_open:
			anim.play("Cube_Bounce")
		else:
			anim.play_backwards("Cube_Bounce")

func _sit_chair() -> void:
	PlayerStats.is_sitting = not PlayerStats.is_sitting
