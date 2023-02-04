extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_node("Player").connect("onHit",self,"update_lives")
	GC.LIVES = 3
	update_lives()

func update_lives():
	for img in $Lives.get_children():
		if GC.LIVES>img.get_index(): img.modulate = Color(1,1,1,1)
		else:  img.modulate = Color(.1,.1,.1,1)
