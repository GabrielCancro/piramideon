extends KinematicBody2D

var velocity = Vector2()
var speed = 50
var dir = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity = move_and_slide(Vector2(speed*dir,0),Vector2.UP)
	update_rays()
	if $RayLeft.is_colliding(): dir = 1
	elif $RayRight.is_colliding(): dir = -1
	elif !$RayDownLeft.is_colliding() && dir==-1: dir = 1
	elif !$RayDownRight.is_colliding() && dir==1: dir = -1

func update_rays():
	$RayLeft.force_raycast_update()
	$RayDownLeft.force_raycast_update()
	$RayRight.force_raycast_update()
	$RayDownRight.force_raycast_update()
