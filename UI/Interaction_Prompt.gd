class_name InteractionPrompt
extends Label

static var instance: InteractionPrompt

func _ready() -> void:
	instance = self
	visible = false

func show_prompt(promptText: String) -> void:
	visible = true
	text = "[%s] " % _get_key_label("interact") + promptText

func hide_prompt() -> void:
	visible = false

func _get_key_label(inputKey: String) -> String:
	# Checks what key is assigned currently to an action, in this case "interact"
	# Godot has different keycode checks, so we check for both
	for _inputEvent in InputMap.action_get_events(inputKey):
		if _inputEvent is InputEventKey:
			if _inputEvent.physical_keycode != 0:
				return _inputEvent.as_text_physical_keycode()
			elif _inputEvent.keycode != 0:
				return _inputEvent.as_text_keycode()
	return "?"
