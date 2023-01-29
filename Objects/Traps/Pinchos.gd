extends Node2D

func _ready():
	$Area2D.connect("body_entered",self,"onBody")

func onBody(body):
	if body.has_method("hit"): body.hit()
