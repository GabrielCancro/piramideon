extends Sprite


func _ready():
	$Area2D.connect("body_entered",self,"onBodyEnter")

func onBodyEnter(body):
	if body.has_method("hit"): body.hit()
