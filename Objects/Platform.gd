extends KinematicBody2D

export var toX = 3
export var toY = 0
export var delay = .5
export var speed = 5
export var loop = true

var start_pos = Vector2()
var end_pos = Vector2()
var destine = Vector2()
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = position
	end_pos = start_pos + Vector2(toX*32,toY*32)
	move_to(end_pos)

func move_to(pos):
	var time = 1
	$Tween.interpolate_property(self,"position",position,pos,time,Tween.TRANS_SINE,Tween.EASE_IN_OUT,delay)
	$Tween.start()
	if loop:
		yield($Tween,"tween_all_completed")
		if position.distance_to(end_pos)<1: move_to(start_pos)
		else: move_to(end_pos)
