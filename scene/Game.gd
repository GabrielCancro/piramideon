extends Control

func _ready():
	GC.GAME_REF = self
	var level = load("res://Levels/Level"+str(GC.LEVEL)+".tscn").instance()
	add_child(level)
	$Player.position = level.get_node("StartPoint").position
	$Player.checkpoint_position = $Player.position
	$Player.checkpoint_position = $Player.position
	level.get_node("StartPoint").visible = false

func _process(delta):
	$CanvasUI/lb_vel.text = "velocity " + str( int( $Player.velocity.x / 10 ) * 10 )
