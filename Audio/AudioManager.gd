extends Node
class_name AudioManager

@export var audio_event:FmodEventEmitter3D
	
func one_shot(event_emitter_3d: FmodEventEmitter3D) -> void:
	event_emitter_3d.play_one_shot()

func play_loop(event_emitter_3d: FmodEventEmitter3D) -> void:
	event_emitter_3d.play()

func stop(event_emitter_3d: FmodEventEmitter3D) -> void:
	event_emitter_3d.stop()

func modify_parameter(event_emitter_3d: FmodEventEmitter3D, parameter: String, value: Variant) -> void:
	event_emitter_3d.set_parameter(parameter, value)
