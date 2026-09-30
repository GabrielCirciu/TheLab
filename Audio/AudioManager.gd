extends Node
class_name AudioManager
@export var _fmodEventEmitter:FmodEventEmitter3D
@export_custom(PROPERTY_HINT_NONE, "FmodEvent") var event_path: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	oneshot(event_path)
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func oneshot(event: String) -> void:
	_fmodEventEmitter.event_name = event
	_fmodEventEmitter.play()
	pass
