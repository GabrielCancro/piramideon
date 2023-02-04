extends Control

func _ready():
	GC.GAME_REF = self
	var level = load("res://Levels/Level"+str(GC.LEVEL)+".tscn").instance()
	add_child(level)
	$Player.position = level.get_node("StartPoint").position
	$Player.checkpoint_position = $Player.position
	$Player.checkpoint_position = $Player.position
	$Player.connect("onDead",self,"onDead")
	level.get_node("StartPoint").visible = false

func _process(delta):
	$CanvasUI/lb_vel.text = "velocity " + str( int( $Player.velocity.x / 10 ) * 10 )

func onDead():
	get_tree().change_scene("res://scene/SelectLevel.tscn")

func win_level():
	#CALLED FROM DOOR OBJECT
	$CanvasUI/BlackScreen.blackIn(1.0)
	GC.PLAYER_REF.modulate.a = .5
	GC.PLAYER_REF.isDisable = true
	yield($CanvasUI/BlackScreen,"end_animation")	
	get_tree().change_scene("res://scene/SelectLevel.tscn")
