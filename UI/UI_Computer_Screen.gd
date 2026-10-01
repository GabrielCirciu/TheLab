extends Node3D

@onready var correct = $SubViewport/GUI/Correct
@onready var incorrect = $SubViewport/GUI/Incorrect

var _old_correct_count : int = 0
var _old_wrong_count : int = 0

func _ready() -> void:
	correct.visible = false
	incorrect.visible = false

func _process(_delta: float) -> void:
	var _correct_count : int = GameStats.correct_count
	var _wrong_count : int = GameStats.wrong_count
	if _correct_count > _old_correct_count:
		correct.visible = true
		incorrect.visible = false
		_old_correct_count = _correct_count
	elif _wrong_count > _old_wrong_count:
		incorrect.visible = true
		correct.visible = false
		_old_wrong_count = _wrong_count
	
