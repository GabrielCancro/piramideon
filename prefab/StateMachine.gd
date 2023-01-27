extends Node

enum States { IDLE, PATROL, ATTACK }
var current_state = null
var last_state = null

func _ready():
	change_state(States.IDLE)

func change_state(new_state):
	new_state = States.keys()[new_state]
	if last_state && has_method("exit_"+last_state): call("exit_"+last_state)
	last_state = current_state
	if has_method("enter_"+new_state): call("enter_"+new_state)
	current_state = new_state

func _process(delta):
	if has_method("update_"+current_state): call("update_"+current_state)

#START STATES FUNCTIONS
#-----------------------IDLE
func enter_IDLE():
	print("enter IDLE")
	pass

func update_IDLE():
	pass

#-----------------------PATROL
func enter_PATROL():
	pass

func exit_PATROL():
	pass

func update_PATROL():
	pass
