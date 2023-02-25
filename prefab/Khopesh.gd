extends Node2D

var dir = Vector2()
var start_speed = 300
var back = 250
var rot = 12
var speed

func _ready():
	$Area2D.connect("body_entered",self,"onBody")
	speed = start_speed
	GC.PLAYER_REF.hadKhopesh = false

func _process(delta):
	rotation_degrees += rot
	if speed>0: 
		position += dir*delta*speed
	else: 
		position -= position.direction_to(GC.PLAYER_REF.position)*delta*speed
		if position.distance_to(GC.PLAYER_REF.position) < 16: end_khopse()
	speed -= delta*back

func onBody(body):
	print("Khopesh hit "+body.name)
	if body.name=="Player": return	
	if body.has_method("hit"): 
		body.hit()
		$Area2D/CollisionShape2D.disabled = true
	if speed>0: speed = 0
	else: end_khopse()

func end_khopse():
	GC.PLAYER_REF.hadKhopesh = true
	queue_free()
