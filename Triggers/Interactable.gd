class_name Interactable
extends Area3D

signal interacted(interactor: Node)

enum Kind { GENERIC, BUTTON, DOOR, CHAIR }

@export_group("General")
@export var kind: Kind = Kind.GENERIC
@export var prompt_text := "<NO PROMPT SET>"
@export var anim: AnimationPlayer = null
	
var is_open := false # only used by doors

@export_group("Chair")
@export var seat_point: Marker3D
@export var exit_point: Marker3D 

@export_group("Button")
@export var button: GameStats.Buttons = GameStats.Buttons.NONE


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
			if PlayerStats.current_chair == self:
				stand(interactor)
			else:
				sit(interactor)
		_:
			pass
	InteractionPrompt.instance.show_prompt(prompt_text)

func _press_button() -> void:
	GameStats.interacted_button = button
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

func sit(interactor: Node) -> void:
	if PlayerStats.is_sitting:
		return
	var player : Player = interactor
	player.teleport_to(seat_point.global_position, seat_point.global_rotation.y)
	PlayerStats.is_sitting = true
	PlayerStats.current_chair = self
	prompt_text = "Stand"
	_refresh_prompt()

func stand(interactor: Node) -> void:
	var player : Player = interactor
	player.teleport_to(exit_point.global_position)
	PlayerStats.is_sitting = false
	PlayerStats.current_chair = null
	prompt_text = "Sit"
	_refresh_prompt()

func _refresh_prompt() -> void:
	if PlayerStats.current_interactable == self:
		InteractionPrompt.instance.show_prompt(prompt_text)
