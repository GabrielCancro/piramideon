extends Node2D

var acid_drop_scene = preload("res://Objects/AcidDrop.tscn")
export var time = 2.0
export var delay = 0.0

func _ready():
	$Timer.wait_time = time
	$Timer.connect("timeout",self,"onTime")
	yield(get_tree().create_timer(delay),"timeout")
	$Timer.start()

func onTime():
	var ob = acid_drop_scene.instance()
	ob.position = Vector2(0,8)
	add_child(ob)
