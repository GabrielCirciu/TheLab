extends Node

enum Emotion { HAPPY, SAD, ANGRY, NONE }
var baby_state : Emotion = Emotion.NONE

enum Buttons { BUTTON1, BUTTON2, BUTTON3, NONE }
var interacted_button : Buttons = Buttons.NONE

var correct:bool = false
var wrong_max: int = 10
var wrong_current: int = 0
var correct_current: int = 0
var emotions_total: int = 3
var game_over: bool = false
