extends KinematicBody2D

var velocity = Vector2(550,-500)
var ttl = 100
var collider = null

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if collider: 
		ttl -= 1
		modulate.a = ttl/100.0
		if(ttl<=0): queue_free()
	else:
		velocity.y += GC.GRAVITY*.8
		collider = move_and_collide(velocity * delta)
		if collider: $CollisionShape2D.disabled = true
		look_at(position+velocity)
