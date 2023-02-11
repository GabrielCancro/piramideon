extends Node2D

export var trigger_id = "MechanismA"
var actived = false

func _ready():
	$Area2D.connect("body_entered",self,"onBodyEnter")
	$Area2D.connect("body_exited",self,"onBodyExit")

func onBodyEnter(body):
	if body==GC.PLAYER_REF:
		GC.PLAYER_REF.interact_object = self

func onBodyExit(body):
	if body==GC.PLAYER_REF:
		if GC.PLAYER_REF.interact_object==self:
			GC.PLAYER_REF.interact_object = null

func activate():
	actived = !actived
	$Sprite.flip_v = !actived
	GC.emit_signal("on_trigger",trigger_id,actived)
