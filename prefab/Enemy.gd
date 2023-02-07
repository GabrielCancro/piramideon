extends KinematicBody2D

var velocity = Vector2()
var speed = 50
var dir = 1
var isDisabled = false

func _ready():
	$Area2D.connect("body_entered",self,"onBody")

func _physics_process(delta):
	if isDisabled:return
	velocity = move_and_slide(Vector2(speed*dir,0),Vector2.UP)
	update_rays()
	if $RayLeft.is_colliding() && $RayLeft.get_collider()!=GC.PLAYER_REF: dir = 1
	elif $RayRight.is_colliding() && $RayLeft.get_collider()!=GC.PLAYER_REF: dir = -1
	elif !$RayDownLeft.is_colliding() && dir==-1: dir = 1
	elif !$RayDownRight.is_colliding() && dir==1: dir = -1

func update_rays():
	$RayLeft.force_raycast_update()
	$RayDownLeft.force_raycast_update()
	$RayRight.force_raycast_update()
	$RayDownRight.force_raycast_update()

func hit(val=1):
	if isDisabled:return
	isDisabled = true
	modulate.a = .5
	yield(get_tree().create_timer(1),"timeout")
	queue_free()

func onBody(body):
	if isDisabled:return
	if body == self: return
	if body.has_method("hit"): body.hit()
