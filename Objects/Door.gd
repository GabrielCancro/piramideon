extends Node2D

func _ready():
	$Area2D.connect("body_entered",self,"onBody")

func onBody(body):
	if body.name != "Player": return
	GC.DATA.level_success.append(GC.LEVEL)
	GC.GAME_REF.win_level()
