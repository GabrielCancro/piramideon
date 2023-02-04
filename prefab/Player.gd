extends KinematicBody2D

var velocity = Vector2(150,0)
var mov =  Vector2(0,0)
var impulse =  Vector2(0,0)
var power_jump = 0
var power_jump_inc = 0
var power_atk = 0
var power_atk_inc = 0
var climb_pos = Vector2(0,0)

var atSpeed = 150
var atJump = 750
var atAttack = 750

var isDisable = false
var checkpoint_position = Vector2()

var cChain = 0

onready var SB_jump = get_node("/root/Game/CanvasUI/Right/SB_jump")
onready var SB_attack = get_node("/root/Game/CanvasUI/Right/SB_attack")
onready var SB_move = get_node("/root/Game/CanvasUI/Left/SB_move")

signal onHit
signal onDead

func _ready():
	SB_jump.connect("onUpVector",self,"onJump")
	SB_attack.connect("onUpVector",self,"onAttack")
	checkpoint_position = position
	GC.PLAYER_REF = self

func _physics_process(delta):
	if isDisable: return
	mov = SB_move.percent_vec
	if(abs(velocity.x)<abs(mov.x)*atSpeed): velocity.x += mov.x * 20
	if inFloor(): velocity.x *= .90
	elif cChain==0: velocity.y += GC.GRAVITY
	if(climb_pos.length()!=0): velocity = Vector2.ZERO
	velocity = move_and_slide(velocity,Vector2(0, -1))
	$prg_jump.direction = SB_jump.percent_vec
	$prg_attack.direction = SB_attack.percent_vec

func onJump(dir,percent):
	if isDisable: return
	if inFloor() || climb_pos.length()!=0:
		velocity = Vector2(0,-50) + dir * atJump * $prg_jump.power*.01;
		climb_pos = Vector2.ZERO

func onAttack(dir,percent):
	if isDisable: return
	var pry = preload("res://prefab/Proyectil.tscn").instance()
	pry.position = position + dir*30
	pry.velocity = atAttack*dir*$prg_attack.power*.01
	get_node("/root/Game").add_child(pry)

func inFloor():
	$RayBottom.force_raycast_update()
	$RayBottom2.force_raycast_update()
	return $RayBottom.is_colliding() || $RayBottom2.is_colliding()

func hit(val=1):
	modulate.a = .5
	isDisable = true
	GC.LIVES -= 1
	emit_signal("onHit")
	yield(get_tree().create_timer(1),"timeout")	
	if(GC.LIVES>0): 
		modulate.a = 1
		isDisable = false
		position = checkpoint_position
	else:
		emit_signal("onDead")

func fastenChain(val):
	cChain += val
	if val>0: velocity = Vector2(0,0)
