extends TextureProgress

export var min_amount = 30
export var max_amount = 100
var inc_amount = 2
var power = 0
var power_segment = 0
var direction = Vector2()


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	visible = (direction.length()>0)
	if !visible: 
		power = min_amount
		inc_amount = 2
		return
	if power < min_amount: inc_amount = +2
	elif power > max_amount-10: inc_amount = -2
	power += inc_amount
	rect_rotation = rad2deg(direction.angle() ) + 90
	power_segment = 20+floor(power/20)*20
	value = power_segment
