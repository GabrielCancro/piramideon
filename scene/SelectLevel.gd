extends Control

var max_levels = 4

func _ready():
	setPiram()
	print("SUCCESS LEVELS: ",GC.DATA.level_success)

func setPiram():
	var i = 1
	for r in $Piramid.get_children():
		for b in r.get_children():
			b.set_text(i)
			b.connect("button_down",self,"onButtonClick",[b,i])
			if i>max_levels: b.set_available(false)
			i+=1

func onButtonClick(btn,index):
	GC.LEVEL = index
	get_tree().change_scene("res://scene/Game.tscn")
