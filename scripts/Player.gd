extends KinematicBody2D

var new_hit = 0
var timer
const MOTION_SPEED = 250

func _ready():
	randomize()
	#timer = get_node("Damage/Timer")
	timer = get_node("Weapon/Timer")
	set_fixed_process(true)

func _fixed_process(delta):
	var motion = Vector2()
	var move_up = Input.is_action_pressed("move_up")
	var move_down = Input.is_action_pressed("move_down")
	var move_left = Input.is_action_pressed("move_left")
	var move_right = Input.is_action_pressed("move_right")
	var player = get_node("AnimatedSprite")
	
	if Input.is_action_pressed("ui_select"):
		if (timer.get_time_left() == 0):
			get_node("Weapon").show()
			if (get_node("Weapon").get_rot() > 3):
				get_node("Weapon/Anim").play("suburileft")
			else: 
				get_node("Weapon/Anim").play("suburiright")
			timer.start()
	
	if (timer.get_time_left() <= 0.1):
		get_node("Weapon").hide()
		
		"""if (timer.get_time_left() <= 0.7):
			if (timer.get_time_left() == 0):
				new_hit = 0
			timer.start()
			new_hit += rand_range(1, 100)
			get_node("Damage").set_text(str(round(new_hit)))
			get_node("Damage/Anim").play("hit")"""
	
	#animation
	if move_up:
		motion += Vector2(0, -1)
		player.play("MoveUp")
	if move_down:
		motion += Vector2(0, 1)
		player.play("MoveDown")
	if move_left:
		motion += Vector2(-1, 0)
		player.set_flip_h(false)
		get_node("Weapon").set_rot(3.14)
		if move_down:
			player.play("MoveLeftDown")
		elif move_up:
			player.play("MoveLeftUp")
		else:
			player.play("MoveLeft")
	if move_right:
		motion += Vector2(1, 0)
		player.set_flip_h(true)
		get_node("Weapon").set_rot(0)
		if move_down:
			player.play("MoveRightDown")
		elif move_up:
			player.play("MoveRightUp")
		else:
			player.play("MoveRight")
	
	
	
	motion = motion.normalized()*MOTION_SPEED*delta
	motion = move(motion)
	
	if (is_colliding()):
		get_collider().move(get_collision_normal() * (-1))
	
	var icon = get_tree().get_nodes_in_group("hud")[0].get_node("MapPanel/Map/PlayerIcon")
	icon.set_pos(get_pos() / 5)
	
	var minimap = get_tree().get_nodes_in_group("hud")[0].get_node("MinimapPanel/TextureFrame")
	minimap.set_pos(get_pos() * (-1) / 10)
	
#	var slide_attempts = 4
#	while(is_colliding() and slide_attempts > 0):
#		motion = get_collision_normal().slide(motion)
#		motion = move(motion)
#		slide_attempts -= 1



func save():
	var save_dict = {
		pos = {
			x = get_pos().x,
			y = get_pos().y
		},
		scene = get_parent().get_name(),
		quests = global.player_quests,
		inventory = global.player_inv,
		money = global.money,
	}
	return save_dict