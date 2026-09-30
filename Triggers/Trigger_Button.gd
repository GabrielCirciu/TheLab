extends Node3D


@export var button: GameStats.Buttons = GameStats.Buttons.NONE

@onready var interactable: Interactable = $Button/Area3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.button = button

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
