extends KinematicBody2D

export var toX = 3
export var toY = 0
export var speed = 70

var start_pos = Vector2()
var end_pos = Vector2()
var destine = Vector2()
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = position
	end_pos = start_pos + Vector2(toX*32,toY*32)
	destine = end_pos

func _physics_process(delta):
	var mov = position.direction_to(destine)*speed*delta
	position += mov
#	velocity = move_and_collide(mov*delta)
	if position.distance_to(start_pos)<=speed/20: destine = end_pos
	if position.distance_to(end_pos)<=speed/20: destine = start_pos
