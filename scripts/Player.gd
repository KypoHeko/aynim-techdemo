extends KinematicBody2D

var new_hit = 0
var timer
const MOTION_SPEED = 300

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
	
	if Input.is_action_pressed("ui_select"):
		if (timer.get_time_left() == 0):
			get_node("Weapon").show()
			get_node("Weapon/Anim").play("suburi")
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
	
	if move_up:
		motion += Vector2(0, -1)
	if move_down:
		motion += Vector2(0, 1)
	if move_left:
		motion += Vector2(-1, 0)
	if move_right:
		motion += Vector2(1, 0)
	
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
		scene = get_parent().get_name()
	}
	return save_dict