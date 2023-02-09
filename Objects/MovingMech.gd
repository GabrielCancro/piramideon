extends Node2D

export var toX = 3
export var toY = 0
export var delay = .5
export var speed = 5
export var loop = true
export var active = true

enum MoveEnum {TRANS_LINEAR, TRANS_SINE}
export(MoveEnum) var moveType = MoveEnum.TRANS_SINE

var start_pos = Vector2()
var end_pos = Vector2()
var destine = Vector2()

func _ready():
	start_pos = position
	end_pos = start_pos + Vector2(toX*32,toY*32)
	move_to(end_pos)

func move_to(pos):
	if !active: return
	var time = start_pos.distance_to(end_pos)/32.0/speed
	$Tween.interpolate_property(self,"position",position,pos,time,moveType,Tween.EASE_IN_OUT,delay)
	$Tween.start()
	if loop:
		yield($Tween,"tween_all_completed")
		if position.distance_to(end_pos)<1: move_to(start_pos)
		else: move_to(end_pos)

func activate():
	active = true
	if position.distance_to(end_pos)<1: move_to(start_pos)
	else: move_to(end_pos)

func desactivate():
	active = false
