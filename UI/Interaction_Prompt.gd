extends Label

var key_text := "a"

func _ready() -> void:
	visible = false
	key_text = _get_key_label("interact")

func _on_prompt_changed(prompt: String) -> void:
	visible = prompt != ""
	self.text = "[%s] " % _get_key_label("interact") + prompt

func _get_key_label(action: String) -> String:
	# Checks what key is assigned currently to an action, in this case "interact"
	# Godot has different keycode checks, so we check for both
	for event in InputMap.action_get_events(action):
		if event is InputEventKey:
			if event.physical_keycode != 0:
				return event.as_text_physical_keycode()
			elif event.keycode != 0:
				return event.as_text_keycode()
	return "?"
