extends Control

func _ready():
	var level = preload("res://Levels/Level1.tscn").instance()
	add_child(level)
	$Player.position = level.get_node("StartPoint").position
	level.get_node("StartPoint").visible = false

func _process(delta):
	$CanvasUI/lb_vel.text = "velocity " + str( int( $Player.velocity.x / 10 ) * 10 )
