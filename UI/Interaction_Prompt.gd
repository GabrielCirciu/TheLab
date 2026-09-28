extends Label

func _ready() -> void:
	visible = false

func _on_player_prompt_changed(prompt: String) -> void:
	visible = prompt != ""
	self.text = "[E] " + prompt
