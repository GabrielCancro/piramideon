extends KinematicBody2D

var velocity = Vector2(150,0)
var mov =  Vector2(0,0)
var impulse =  Vector2(0,0)
var power_jump = 0
var power_jump_inc = 0
var power_atk = 0
var power_atk_inc = 0
var climb_pos = Vector2(0,0)

onready var SB_jump = get_node("/root/Game/CanvasUI/SB_jump")
onready var SB_attack = get_node("/root/Game/CanvasUI/SB_attack")

func _ready():
	SB_jump.connect("onUpVector",self,"onJump")
	SB_attack.connect("onUpVector",self,"onAttack")

func _physics_process(delta):
	mov = GC.PAD.mov_vec
	if(abs(velocity.x)<abs(mov.x)*300): velocity.x += mov.x * 20
	if inFloor(): velocity.x *= .95
	else: velocity.y += GC.GRAVITY
	if(climb_pos.length()!=0): velocity = Vector2.ZERO
	velocity = move_and_slide(velocity,Vector2(0, -1))
	_process_special_jump()
	_process_attack()
	_process_tilemap_collision()

func _process_special_jump():
	if SB_jump.percent_vec.length()==0: 
		$prg.visible = false
		return
	$prg.visible = true
	if power_jump < 50: power_jump_inc = 2
	elif power_jump > 100: power_jump_inc = -2
	power_jump += power_jump_inc
	$prg.rect_rotation = rad2deg(SB_jump.percent_vec.angle() ) + 90
	$prg.value = power_jump

func _process_attack():
	if(SB_attack.percent_vec.length()==0): 
		$prg2.visible = false
		return
	$prg2.visible = true
	if power_atk < 20: power_atk_inc = 2
	elif power_atk > 100: power_atk_inc = -2
	power_atk += power_atk_inc
	$prg2.rect_rotation = rad2deg( SB_attack.percent_vec.angle() ) + 90
	$prg2.value = power_atk

func _process_tilemap_collision():
	if inFloor(): return
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.collider is TileMap:
			var cell = collision.collider.world_to_map(collision.position - collision.normal) / 2
			var tileId = collision.collider.get_cellv(cell)
			if(tileId==1): climb_pos = position
			print("tileId ", tileId)

func onJump(dir,percent):
	if inFloor() || climb_pos.length()!=0:
		velocity = Vector2(0,-50) + dir * 400 + dir * power_jump * 5;
		climb_pos = Vector2.ZERO
	power_jump = 0

func onAttack(dir,percent):
	var pry = preload("res://prefab/Proyectil.tscn").instance()
	pry.position = position + dir*70
	pry.velocity = dir*200+dir*power_atk*5
	power_atk = 0
	get_node("/root/Game").add_child(pry)

func inFloor():
	$RayBottom.force_raycast_update()
	$RayBottom2.force_raycast_update()
	return $RayBottom.is_colliding() || $RayBottom2.is_colliding()
