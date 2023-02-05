extends Node2D

func _ready():
	$Area2D.connect("body_entered",self,"onEnterBody")

func onEnterBody(body):
	if body.name == "Player":
		GC.RESTART_POSITION = position
		modulate.a = 1
		print("CHANGE RESTART POSITION")
