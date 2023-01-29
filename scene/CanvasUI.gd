extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_node("Player").connect("onHit",self,"update_lives")
	update_lives()

func update_lives():
	for img in $Lives.get_children():
		if GC.LIVES>img.get_index(): img.modulate = Color(1,1,1,1)
		else:  img.modulate = Color(.1,.1,.1,1)
