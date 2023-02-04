extends Button

func _ready():
	set_available(true)

func set_text(text):
	$Label.text = str(text)

func set_available(isAvailable):
	disabled = !isAvailable
	if isAvailable: modulate = Color(1,1,1,1)
	else: modulate = Color(.5,.5,.5,1)
