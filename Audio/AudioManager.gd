extends Node
class_name AudioManager

@export var audioEvent:FmodEventEmitter3D
	
func Oneshot(eventEmitter3D: FmodEventEmitter3D) -> void:
	eventEmitter3D.play_one_shot()
	pass

func PlayLoop(eventEmitter3D: FmodEventEmitter3D) -> void:
	eventEmitter3D.play()
	pass

func Stop(eventEmitter3D: FmodEventEmitter3D) -> void:
	eventEmitter3D.stop()
	pass

func ModifyParameter(eventEmitter3D: FmodEventEmitter3D, parameter: String, value: Variant) -> void:
	eventEmitter3D.set_parameter(parameter, value)
	pass
