class_name GameManager
extends Node

@export var babySFX: FmodEventEmitter3D
@export var next_baby_timer: float =  1.0

# Which baby emotion each physical button answers
var button_to_emotion := {
	GameStats.Buttons.BUTTON1: GameStats.Emotion.HAPPY,
	GameStats.Buttons.BUTTON2: GameStats.Emotion.SAD,
	GameStats.Buttons.BUTTON3: GameStats.Emotion.ANGRY,
}

var babyIdString : String = "BABY #"
var pressed : GameStats.Buttons = GameStats.interacted_button

var _clear_timer : Timer

func _ready() -> void:
	_clear_timer = Timer.new()
	_clear_timer.one_shot = true
	_clear_timer.timeout.connect(_next_baby)
	add_child(_clear_timer)
	_clear_timer.start(next_baby_timer)

func _process(_delta: float) -> void:
	pressed = GameStats.interacted_button
	GameStats.interacted_button = GameStats.Buttons.NONE
	if pressed == GameStats.Buttons.NONE or GameStats.game_over:
		return
	
	if pressed == GameStats.Buttons.NEW_BABY: 
		if GameStats.ready_for_next_baby:
			GameStats.ready_for_next_baby = false
			babySFX.stop()
			_clear_timer.start(next_baby_timer)
		return
	
	if GameStats.ready_for_next_baby:
		return

	if button_to_emotion[pressed] == GameStats.baby_state:
		print("Correct!")
		GameStats.correct_count += 1
	else:
		print("Wrong!")
		GameStats.wrong_count += 1
		
	if GameStats.correct_count + GameStats.wrong_count <= GameStats.answers_max:
		_pick_new_emotion()
	elif GameStats.correct_count > GameStats.wrong_count:
		GameStats.ready_for_next_baby = true
	else:
		_game_over()

func _pick_new_emotion() -> void:
	# NONE is the last enum value, so it's excluded from the roll
	GameStats.baby_state = randi_range(0, GameStats.Emotion.NONE - 1) as GameStats.Emotion
	var _feeling : String = ""
	
	babySFX.stop()
	babySFX.set_parameter("BabyState", GameStats.baby_state)
	print("Parameter is: ",babySFX.get_parameter("BabyState"))
	babySFX.play(true)
	
	match GameStats.baby_state:
		0:
			_feeling = "happy"
			
		1:
			_feeling = "sad"
		2:
			_feeling = "angry"
		_:
			pass
	GameStats.baby_feeling = "Baby is " + _feeling + "."
	print("Baby is: ", GameStats.Emotion.keys()[GameStats.baby_state])
	# Sound stuff would be set here

func _next_baby():
	print("Next baby coming")
	GameStats.correct_count = 0
	GameStats.wrong_count = 0
	GameStats.answers_max += 2
	_increase_babyID()
	_pick_new_emotion()
	# Potential game difficulty increase would be set here

func _increase_babyID() -> void:
	GameStats.baby_number += 1 
	GameStats.baby_ID = babyIdString+ "%04d" % GameStats.baby_number
	

func _game_over() -> void:
	print("You lose!")
	GameStats.game_over = true
	# Scary stuff can be set here
