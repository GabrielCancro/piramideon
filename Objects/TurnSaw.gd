extends Node2D

func _ready():
	$Area2D.connect("body_entered",self,"onBodyEnter")

func _process(delta):
	$Sprite.rotation_degrees += 7

func onBodyEnter(body):
	if body.has_method("hit"): body.hit()
