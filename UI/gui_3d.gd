extends Node3D

@onready var correct = $SubViewport/GUI/Correct
@onready var incorrect = $SubViewport/GUI/Incorrect

func _ready() -> void:
	correct.visible = false
	incorrect.visible = false

func _process(_delta: float) -> void:
	if GameStats.correct:
		correct.visible = true
		incorrect.visible = false
	else:
		incorrect.visible = true
		correct.visible = false
	
