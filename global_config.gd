extends Node

var GRAVITY = 25
var LIVES
var LEVEL = 0
var RESTART_POSITION = Vector2()
var CAMERA_TIME = 1.5
var DATA = {
	level_success = []
}
signal on_trigger(trigger_id,is_actived)

var GAME_REF
var PLAYER_REF

func _ready():
	pass

func cameraLookEffect(pos):
	PLAYER_REF.isDisable = true
	PLAYER_REF.get_node("Camera2D").global_position = pos
	yield(get_tree().create_timer(CAMERA_TIME),"timeout")
	PLAYER_REF.isDisable = false
	PLAYER_REF.get_node("Camera2D").position = Vector2()
