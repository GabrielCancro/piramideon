extends Area2D

export var speed = 200

func _ready():
	connect("body_entered",self,"onBody")
	
func _process(delta):
	position.y += speed*delta

func onBody(body):
	if body.has_method("hit"): body.hit()
	queue_free()
