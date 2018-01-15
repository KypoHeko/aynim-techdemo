extends KinematicBody2D

onready var HUD = get_tree().get_nodes_in_group("hud")[0]
onready var LOOT = get_tree().get_nodes_in_group('loot')[0]

var new_hit = 0
var hp = 100
var dead = false
var inv = [1, 2]
var timer

func _ready():
	set_z(get_pos().y)

func _on_Area2D_area_enter( area ):
	timer = get_node("Damage/Timer")
	
	if (area.get_name() == "Weapon"):
		get_node("Hit").play()
		if (timer.get_time_left() <= 0.7):
			if (timer.get_time_left() == 0):
				new_hit = 0
			timer.start()
			new_hit = rand_range(2, 40)
			hp -= new_hit
			get_node("Damage").set_text(str(round(new_hit)))
			get_node("Damage/Anim").play("hit")
	
	get_node("HP").set_value(hp)
	
	#условия при смерти врага
	if hp <= 0:
		dead = true
		global.add_stat(1)
		get_node("Area2D").queue_free()
		get_node("HP").hide()
		
		
		#реализация "выпадения" вещей
		"""
		for i in inv:
			var add_drop = preload("res://scenes/Drop.tscn")
			var drop = add_drop.instance()
			drop.set_pos(get_pos())
			drop.id[0] = i
			get_parent().add_child(drop)"""


func _on_Area2D1_body_enter( body ):
	if (body.get_name() == "Player"):
		#если враг жив
		if dead == false:
			HUD.get_node("Action").show()
			HUD.get_node("Action/Label").set_text("Attack!")
			HUD.get_node("Joystick/Panel/Stick").set_pos(Vector2(100, 100))
			#get_tree().set_pause(true)
			get_node("HP").show()
			global.BattleStart()
		#если враг мертв
		if dead == true:
			#загружаем список предметов в окно Loot
			LOOT.loot = inv
			HUD.get_node("Action/Label").set_text("Loot!")
			HUD.get_node("Action").show()

func _on_Area2D1_body_exit( body ):
	print(get_name(), " ", inv)
	HUD.get_node("Action").hide()
	HUD.get_node("bazaar").hide()
	HUD.get_node("Loot").hide()
	get_tree().set_pause(false)
	get_node("HP").hide()
	global.BattleEnd()
