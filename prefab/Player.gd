extends KinematicBody2D

var velocity = Vector2(150,0)
var mov =  Vector2(0,0)
var walk_speed = 60
var impulse =  Vector2(0,0)
var power_jump = 0
var power_jump_inc = 0
var power_atk = 0
var power_atk_inc = 0

var atSpeed = 150
var atJump = 600
var atAttack = 750

var isDisable = false
var isFriction = true

var cChain = 0
var interact_object = null
var hadKhopesh = true

onready var SB_jump = get_node("/root/Game/CanvasUI/Right/SB_jump")
onready var SB_attack = get_node("/root/Game/CanvasUI/Right/SB_attack")
onready var SB_move = get_node("/root/Game/CanvasUI/Left/SB_move")

signal onHit
signal onDead

var max_speed = 200
var max_jump = 350

func _ready():
	SB_jump.connect("onUpVector",self,"onJump")
	SB_jump.connect("pressed",self,"onFastJump")
	SB_attack.connect("onUpVector",self,"onAttack")
	GC.PLAYER_REF = self

func _physics_process(delta):
	$Camera2D/Light2D.texture_scale = rand_range(3.5,3.7)
	mov = SB_move.percent_vec
	if !isDisable:
		if Input.is_action_pressed("ui_left"): mov.x=-1
		if Input.is_action_pressed("ui_right"): mov.x=+1
		if Input.is_action_just_pressed("jump"): onFastJump()
		if Input.is_action_just_released("attack"): onAttack()
		print(velocity.y)
		if !Input.is_action_pressed("jump") && !is_on_floor() && velocity.y<-100: velocity.y+=delta*1500
	
	checkFlipCharacter()
	if checkPointingKhopesh():
		mov = Vector2.ZERO
	if inFloor():
		velocity.x = clamp(velocity.x+mov.x*40,-max_speed,max_speed)
		if (mov.x==0 || sign(mov.x)!=sign(velocity.x)): velocity.x *= .80
	elif !inFloor(): 
		velocity.y += GC.GRAVITY
		if inCornice():
			if velocity.y>=0: velocity.y = 0
			velocity.x = 0
		else:
			velocity.x *= 0.9
			velocity.x = clamp(velocity.x+mov.x*50,-max_speed*1.3,max_speed*1.3)
	if cChain>0: 
		if !isDisable && !checkPointingKhopesh():
			if Input.is_action_pressed("ui_up"): mov.y=-1
			if Input.is_action_pressed("ui_down"): mov.y=+1
		velocity = mov * walk_speed
	velocity = move_and_slide(velocity,Vector2(0, -1))
	$prg_jump.direction = SB_jump.percent_vec
	$prg_attack.direction = SB_attack.percent_vec
	checkAnim()

func onJump(dir,percent):
	if isDisable: return
	if inFloor() || cChain>0:
		if cChain>0: fastenChain(-9999)
		velocity = Vector2(0,-50) + dir * atJump * $prg_jump.power_segment*.01;

func onFastJump():
	if isDisable: return
	if inFloor() || cChain>0:
		if cChain>0: fastenChain(-9999)
		var vx = sign(mov.x)*70
		velocity.y = -max_jump
	if inCornice(): velocity = Vector2(0,-max_jump);

func onAttack():
	if isDisable: return
	if !hadKhopesh: return
	var stickVector: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up","ui_down")
	var pry = preload("res://prefab/Khopesh.tscn").instance()
	pry.dir = Vector2(1,0).rotated($dirAttack.rotation)
	pry.position = position + pry.dir*20
	get_node("/root/Game").add_child(pry)
	isDisable = true
	yield(get_tree().create_timer(.7),"timeout")
	isDisable = false
	
func inFloor():
	$RayBottom.force_raycast_update()
	$RayBottom2.force_raycast_update()
	return $RayBottom.is_colliding() || $RayBottom2.is_colliding()

func hit(val=1):
	if isDisable: return
	modulate.a = .5
	isDisable = true
	GC.LIVES -= 1
	velocity = Vector2()
	emit_signal("onHit")
	yield(get_tree().create_timer(1),"timeout")
	if(GC.LIVES>0): 
		modulate.a = 1
		isDisable = false
		position = GC.RESTART_POSITION
	else:
		emit_signal("onDead")

func fastenChain(val):
	cChain += val
	if cChain<0: cChain = 0
	if val>0: velocity = Vector2(0,0)

func inCornice():
	$RayCornice1.force_raycast_update()
	$RayCornice2.force_raycast_update()
	$RayCornice3.force_raycast_update()
	var res = $RayCornice1.is_colliding() && !$RayCornice2.is_colliding() && !$RayCornice3.is_colliding()
	return res

func checkAnim():
	if isDisable: return
	if inCornice(): $AnimatedSprite.play("cornice")
	elif inFloor() && mov.x==0: $AnimatedSprite.play("idle")
	elif inFloor() && mov.x!=0: $AnimatedSprite.play("walk")
	elif !inFloor(): $AnimatedSprite.play("jump")

func checkFlipCharacter():
	if abs(mov.x)<0.2: return
	if inCornice(): return
	if mov.x<0 == $AnimatedSprite.flip_h: return
	#FLIP
	$AnimatedSprite.flip_h = (mov.x<0)
	$RayCornice1.scale.x = sign(mov.x)
	$RayCornice2.scale.x = sign(mov.x)
	print("FLIP!",$RayCornice2.scale.x)

func checkPointingKhopesh():
	$dirAttack.visible = false
	if isDisable: return false
	if !hadKhopesh: return false
	if Input.is_action_pressed("attack"):
		$dirAttack.visible = true
		var stickVector: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up","ui_down")
		if stickVector.length()==0: stickVector = Vector2($RayCornice1.scale.x,0)
		$dirAttack.rotation = stickVector.angle()
		return true
	return false
