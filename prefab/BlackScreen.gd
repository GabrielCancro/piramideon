extends Control

var auto_out = true
signal end_animation()
# Called when the node enters the scene tree for the first time.
func _ready():
	remove_child($Icon)
	$Bg.visible = true
	if auto_out: blackOut()

func blackIn(delay=0):
	visible = true
	$Bg.modulate = Color(1,1,1,0)
	$Tween.interpolate_property($Bg,"modulate",Color(1,1,1,0),Color(1,1,1,1),1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,delay)
	$Tween.start()
	yield(get_tree().create_timer(1.5),"timeout")
	emit_signal("end_animation")
	
func blackOut(delay=0):
	visible = true
	$Bg.modulate = Color(1,1,1,1)
	$Tween.interpolate_property($Bg,"modulate",Color(1,1,1,1),Color(1,1,1,0),1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,delay)
	$Tween.start()
	yield(get_tree().create_timer(1.1),"timeout")
	emit_signal("end_animation")
	visible = false
	print("END")
