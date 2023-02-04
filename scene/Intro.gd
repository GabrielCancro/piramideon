extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("button_down",self,"onButtonClick")
	$TextureRect.modulate.a = 0
	$Label.modulate.a = 0
	$Tween.interpolate_property($TextureRect,"modulate",Color(1,1,1,0),Color(1,1,1,1),1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,.5)
	$Tween.interpolate_property($Label,"modulate",Color(1,1,1,0),Color(1,1,1,1),.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,1.2)
	$Tween.start()
	yield(get_tree().create_timer(4),"timeout")
	$Tween.interpolate_property($TextureRect,"modulate",Color(1,1,1,1),Color(1,1,1,0),.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,.1)
	$Tween.interpolate_property($Label,"modulate",Color(1,1,1,1),Color(1,1,1,0),.3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()
	yield(get_tree().create_timer(1.5),"timeout")
	get_tree().change_scene("res://scene/SelectLevel.tscn")

func onButtonClick():
	get_tree().change_scene("res://scene/SelectLevel.tscn")
	
