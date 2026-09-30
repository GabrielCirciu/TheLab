class_name InteractionPrompt
extends Label

static var instance: InteractionPrompt

func _ready() -> void:
	instance = self
	visible = false

func show_prompt(prompt_text: String) -> void:
	visible = true
	text = "[%s] " % _get_key_label("interact") + prompt_text

func hide_prompt() -> void:
	visible = false

func _get_key_label(input_key: String) -> String:
	# Checks what key is assigned currently to an action, in this case "interact"
	# Godot has different keycode checks, so we check for both
	for _input_event in InputMap.action_get_events(input_key):
		if _input_event is InputEventKey:
			if _input_event.physical_keycode != 0:
				return _input_event.as_text_physical_keycode()
			elif _input_event.keycode != 0:
				return _input_event.as_text_keycode()
	return "?"
