class_name TextDisplay
extends RichTextLabel

static var instance: TextDisplay

func _ready() -> void:
	instance = self
	visible = false

func animate_labale() ->void:
	visible = true
	


func show_correct_text() -> void:
	instance.bbcode_text= "[color=green]correct![/color]"
	visible = true

func show_wrong_text() -> void:
	text = "Wrong!"
	visible = true

func show_gameover_text() -> void:
	text = "Game Over!"
	visible = true
	
func hide_prompt() -> void:
	visible = false
