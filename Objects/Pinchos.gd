extends Node2D

func _ready():
	$Area2D.connect("body_entered",self,"onBodyEnter")
	$Area2D.connect("body_exited",self,"onBodyExit")

func onBodyEnter(body):
	if body.has_method("hit"): body.hit()
