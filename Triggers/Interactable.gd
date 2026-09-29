class_name Interactable
extends Area3D

signal interacted(interactor: Node)

enum Kind { GENERIC, BUTTON, DOOR, CHAIR }

@export var kind: Kind = Kind.GENERIC
@export var promptText := "Interact"

@onready var anim: AnimationPlayer = get_node_or_null("AnimationPlayer")

var isOpen := false # only used by Kind.DOOR

func focus() -> void:
	InteractionPrompt.instance.show_prompt(promptText)

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
	InteractionPrompt.instance.show_prompt(promptText)

func _press_button() -> void:
	if anim:
		anim.play("press")

func _toggle_door() -> void:
	isOpen = not isOpen
	promptText = "Close" if isOpen else "Open"
	if anim:
		anim.play("Cube_Bounce") if isOpen else anim.play_backwards("Cube_Bounce")

func _sit_chair() -> void:
	print("Sitting")
