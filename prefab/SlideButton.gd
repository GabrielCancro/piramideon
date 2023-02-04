extends TouchScreenButton

var last_touch_index = null
var last_touch_pos = Vector2()
var my_touch_index = null
var start_touch_pos = Vector2()
var dir_vec = Vector2()
var dist = 0
var percent_vec =  Vector2()

export var dist_max = 40
export var dist_min = 20
export var only_horizontal = false

signal onUpVector(dir,percent)
signal onTap()

func _ready():
	connect("pressed",self,"onDownBtn")
	connect("released",self,"onUpBtn")

func onDownBtn():
	modulate.a = .3
	$shadow.visible = true
	$shadow.rect_position = percent_vec * dist_max
	my_touch_index = last_touch_index
	start_touch_pos = last_touch_pos

func onUpBtn():
	modulate.a = 1
	if dist>0: emit_signal("onUpVector",percent_vec.normalized(),percent_vec.length())
	else: emit_signal("onTap")
	$shadow.visible = false
	my_touch_index = null
	start_touch_pos = Vector2()
	dir_vec = Vector2()
	dist = 0
	percent_vec =  Vector2()

func _input(event):
	if event is InputEventScreenTouch && event.pressed:
		last_touch_index = event.index
		last_touch_pos = event.position
	if event is InputEventScreenDrag && event.index == my_touch_index: 
		if only_horizontal: event.position = Vector2(event.position.x,last_touch_pos.y)
		dir_vec = start_touch_pos.direction_to( event.position )
		dist = start_touch_pos.distance_to( event.position )
		if dist > dist_max: dist = dist_max
		if dist < dist_min: dist = 0
		percent_vec = dir_vec * dist / dist_max
		$shadow.rect_position = percent_vec * dist_max
