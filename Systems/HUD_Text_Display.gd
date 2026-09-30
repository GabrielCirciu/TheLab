class_name TextDisplay
extends RichTextLabel

static var instance: TextDisplay

func _ready() -> void:
	instance = self
	visible = false

func show_correct_text() -> void:
	text = "Correct!"
	visible = true

func show_wrong_text() -> void:
	text = "Wrong!"
	visible = true

func show_gameover_text() -> void:
	text = "Wrong!"
	visible = true
	
func hide_prompt() -> void:
	visible = false
