extends KinematicBody2D

export var trigger_id = "MechanismA"
var state = "close" #open
var start_pos
var desp_pos = Vector2(0,-60)

func _ready():
	start_pos = position
	GC.connect("on_trigger",self,"onTrigger")

func close():
	GC.cameraLookEffect(position)
	yield(get_tree().create_timer(GC.CAMERA_TIME/2),"timeout")
	$Tween.stop_all()
	$Tween.interpolate_property(self,"position",position,start_pos,.5,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	$Tween.start()

func open():
	GC.cameraLookEffect(position)
	yield(get_tree().create_timer(GC.CAMERA_TIME/2),"timeout")
	$Tween.stop_all()
	$Tween.interpolate_property(self,"position",position,start_pos+desp_pos,.5,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	$Tween.start()
	
func onTrigger(tid,is_actived):
	if tid != trigger_id: return
	if is_actived: open()
	else: close()
	
