class_name GameManager
extends Node

# Which baby emotion each physical button answers
var button_to_emotion := {
	GameStats.Buttons.BUTTON1: GameStats.Emotion.HAPPY,
	GameStats.Buttons.BUTTON2: GameStats.Emotion.SAD,
	GameStats.Buttons.BUTTON3: GameStats.Emotion.ANGRY,
}

func _ready() -> void:
	_next_baby()

func _process(_delta: float) -> void:
	var pressed := GameStats.interacted_button
	if pressed == GameStats.Buttons.NONE or GameStats.game_over:
		return
	GameStats.interacted_button = GameStats.Buttons.NONE

	if button_to_emotion[pressed] == GameStats.baby_state:
		print("Correct!")	
		GameStats.correct_current += 1
		# TODO: add animation for text fadeout (and maybe fade in)
		TextDisplay.instance.show_correct_text()
	else:
		print("Wrong! (%d/%d)" % [GameStats.wrong_current, GameStats.wrong_max])
		GameStats.wrong_current += 1
		# TODO: add animation for text fadeout (and maybe fade in)
		TextDisplay.instance.show_wrong_text()
		
	if GameStats.correct_current + GameStats.wrong_current <= GameStats.emotions_total:
		_pick_new_emotion()
	elif GameStats.correct_current > GameStats.wrong_current:
		_next_baby()
	else:
		_game_over()

func _pick_new_emotion() -> void:
	# NONE is the last enum value, so it's excluded from the roll
	GameStats.baby_state = randi_range(0, GameStats.Emotion.NONE - 1) as GameStats.Emotion
	print("Baby is: ", GameStats.Emotion.keys()[GameStats.baby_state])
	# Sound stuff would be set here

func _next_baby():
	GameStats.correct_current = 0
	GameStats.wrong_current = 0
	GameStats.emotions_total += 2
	_pick_new_emotion()
	# Potential game difficulty increase would be set here

func _game_over() -> void:
	print("You lose!")
	TextDisplay.instance.show_gameover_text()
	GameStats.game_over = true
	# Scary stuff can be set here
