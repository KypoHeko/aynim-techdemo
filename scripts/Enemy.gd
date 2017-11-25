extends KinematicBody2D

var new_hit = 0
var hp = 100
var timer

func _on_Area2D_area_enter( area ):
	timer = get_node("Damage/Timer")
	
	if (area.get_name() == "Weapon"):
		if (timer.get_time_left() <= 0.7):
			if (timer.get_time_left() == 0):
				hp -= new_hit
				new_hit = 0
			timer.start()
			new_hit += rand_range(1, 20)
			get_node("Damage").set_text(str(round(new_hit)))
			get_node("Damage/Anim").play("hit")
		
	get_node("HP").set_value(hp)
	if hp <= 0:
		global.add_stat(1)
		queue_free()


func _on_Area2D1_body_enter( body ):
	if (body.get_name() == "Player"):
		get_tree().set_pause(true)
		get_node("HP").show()
		global.BattleStart()

func _on_Area2D1_body_exit( body ):
	get_tree().set_pause(false)
	get_node("HP").hide()
	global.BattleEnd()
