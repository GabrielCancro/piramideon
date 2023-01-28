extends Control

func _ready():
	add_child( preload("res://Levels/Level1.tscn").instance() )

func _process(delta):
	$CanvasUI/lb_vel.text = "velocity " + str( int( $Player.velocity.x / 10 ) * 10 )
