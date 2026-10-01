extends Node3D

@onready var correct_color = $SubViewport/GUI/Correct_Color
@onready var incorrect_color = $SubViewport/GUI/Incorrect_Color
@onready var correct_text = $SubViewport/GUI/Correct_Text
@onready var incorrect_text = $SubViewport/GUI/Incorrect_Text

var _old_correct_count : int = 0
var _old_wrong_count : int = 0

func _ready() -> void:
	correct_color.visible = false
	correct_text.visible = false
	incorrect_color.visible = false
	incorrect_text.visible = false

func _process(_delta: float) -> void:
	var _correct_count : int = GameStats.correct_count
	var _wrong_count : int = GameStats.wrong_count
	if _correct_count > _old_correct_count:
		_old_correct_count = _correct_count
		correct_text.visible = true
		correct_color.visible = true
		incorrect_text.visible = false
		incorrect_color.visible = false
		
	elif _wrong_count > _old_wrong_count:
		_old_wrong_count = _wrong_count
		correct_text.visible = false
		correct_color.visible = false
		incorrect_text.visible = true
		incorrect_color.visible = true
