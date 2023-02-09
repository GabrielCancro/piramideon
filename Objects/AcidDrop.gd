extends Area2D

export var speed = 100

func _ready():
	connect("body_entered",self,"onBody")
	
func _process(delta):
	position.y += speed*delta*.5
	if speed<800: speed += delta*speed*2

func onBody(body):
	if body.has_method("hit"): body.hit()
	queue_free()
