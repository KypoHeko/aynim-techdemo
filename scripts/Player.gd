extends KinematicBody2D

var new_hit = 0
var timer = 0
var move_x = 0
var move_y = 0
var direction = "down"

var weapon

const MOTION_SPEED = 250

func _ready():
	#временно, для счетчика урона
	randomize()
	timer = get_node("Weapon/Timer")
	weapon = get_node("Weapon")
	set_fixed_process(true)

func _fixed_process(delta):
	var motion = Vector2()
	var player = get_node("AnimatedSprite")
	
	#анимация атаки
	if Input.is_action_pressed("ui_select"):
		if (timer.get_time_left() == 0):
			get_node("Weapon").show()
			if direction == "left":
				get_node("Weapon/Anim").play("suburileft")
			if direction == "right":
				get_node("Weapon/Anim").play("suburiright")
			if direction == "down":
				get_node("Weapon/Anim").play("suburidown")
			if direction == "up":
				get_node("Weapon/Anim").play("suburiup")
			
			if direction == "leftup":
				get_node("Weapon/Anim").play("suburileftup")
			if direction == "leftdown":
				get_node("Weapon/Anim").play("suburileftdown")
			if direction == "rightup":
				get_node("Weapon/Anim").play("suburirightup")
			if direction == "rightdown":
				get_node("Weapon/Anim").play("suburirightdown")
				
			#if direction == "rightup":
			#	get_node("Weapon/Anim").play("suburiright")
			timer.start()
	
	if (timer.get_time_left() <= 0.1):
		get_node("Weapon").hide()
		
		#счетчик урона
		"""if (timer.get_time_left() <= 0.7):
			if (timer.get_time_left() == 0):
				new_hit = 0
			timer.start()
			new_hit += rand_range(1, 100)
			get_node("Damage").set_text(str(round(new_hit)))
			get_node("Damage/Anim").play("hit")"""
	
	
	
	#анимация и передвижение для стика
	#вниз
	if abs(move_x * 2) < move_y:
		player.play("MoveDown")
		direction = "down"
	#вверх
	if (-1) * abs(move_x * 2) > move_y:
		player.play("MoveUp")
		direction = "up"
	#вправо
	if abs(move_y * 2) < move_x:
		player.set_flip_h(true)
		player.play("MoveRight")
		direction = "right"
	#вправо вверх
	if (abs(move_y / 2) < move_x) and ((-1) * move_y * 2 > move_x):
		player.set_flip_h(true)
		player.play("MoveRightUp")
		direction = "rightup"
	#вправо вниз
	if (abs(move_y / 2) < move_x) and (move_y * 2 > move_x):
		player.set_flip_h(true)
		player.play("MoveRightDown")
		direction = "rightdown"
	#влево
	if (-1) * abs(move_y * 2) > move_x:
		player.set_flip_h(false)
		player.play("MoveLeft")
		direction = "left"
	#влево вверх
	if ((-1) * abs(move_y / 2) > move_x) and (move_y * 2 < move_x):
		player.set_flip_h(false)
		player.play("MoveLeftUp")
		direction = "leftup"
	#влево вниз
	if ((-1) * abs(move_y / 2) > move_x) and ((-1) * move_y * 2 < move_x):
		player.set_flip_h(false)
		player.play("MoveLeftDown")
		direction = "leftdown"
	
	#остановка анимации
	if move_x + move_y == 0:
		player.play("STAY")
		if direction == "down":
			player.set_frame(0)
		if direction == "leftdown":
			player.set_frame(1)
		if direction == "rightdown":
			player.set_frame(1)
		if direction == "left":
			player.set_frame(2)
		if direction == "right":
			player.set_frame(2)
		if direction == "leftup":
			player.set_frame(3)
		if direction == "rightup":
			player.set_frame(3)
		if direction == "up":
			player.set_frame(4)
	#print(move_x, " ", move_y)
	#print(motion)
	
	#анимация и передвижение для клавиатуры
	var move_up = Input.is_action_pressed("move_up")
	var move_down = Input.is_action_pressed("move_down")
	var move_left = Input.is_action_pressed("move_left")
	var move_right = Input.is_action_pressed("move_right")
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
	
	#иконка на карте
	var icon = get_tree().get_nodes_in_group("hud")[0].get_node("MapPanel/Map/PlayerIcon")
	icon.set_pos(get_pos() / 5)
	
	#иконка на миникарте
	var minimap = get_tree().get_nodes_in_group("hud")[0].get_node("MinimapPanel/TextureFrame")
	minimap.set_pos(get_pos() * (-1) / 10)
	
	#реализация передвижения камеры
	var camera_pos = get_tree().get_nodes_in_group("hud")[0].camera_pos
	get_node("Camera2D").set_pos(get_node("Camera2D").get_pos().linear_interpolate(camera_pos, 0.1))
	
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
		active_quests = global.player_quests,
		complete_quests = global.player_c_quests,
		inventory = global.player_inv,
		money = global.money,
	}
	return save_dict