extends Control

func _ready():
	pass 

func _process(delta):
	$CanvasUI/lb_vel.text = "velocity " + str( int( $Player.velocity.x / 10 ) * 10 )
