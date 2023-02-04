extends KinematicBody2D

var velocity = Vector2(550,-500)
var ttl = 100
var collider = null

func _ready():
	$Area2D.connect("body_entered",self,"onBody")

func _physics_process(delta):
	if collider: 
		ttl -= 1
		modulate.a = ttl/100.0
		if(ttl<=0): queue_free()
		$Area2D/CollisionShape2D.disabled = true
	else:
		velocity.y += GC.GRAVITY*.8
		collider = move_and_collide(velocity * delta)
		if collider: $CollisionShape2D.disabled = true
		look_at(position+velocity)

func onBody(body):
	if body.has_method("hit"): 
		body.hit()
		$Area2D/CollisionShape2D.disabled = true
