extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("button_down",self,"onButtonClick")
	visible = false

func show_panel():
	yield(get_tree().create_timer(.5),"timeout")
	modulate = Color(1,1,1,0)
	visible = true
	$Tween.interpolate_property(self,"modulate",Color(1,1,1,0),Color(1,1,1,1),.5,Tween.TRANS_QUAD,Tween.EASE_IN_OUT)
	$Tween.start()

func onButtonClick():
	$Tween.interpolate_property(self,"modulate",Color(1,1,1,1),Color(1,1,1,0),.5,Tween.TRANS_QUAD,Tween.EASE_IN_OUT)
	$Tween.start()
	var BS = get_node("../BlackScreen")
	BS.blackIn(1.0)
	yield(BS,"end_animation")
	get_tree().change_scene("res://scene/SelectLevel.tscn")
