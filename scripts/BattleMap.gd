extends Node2D

var new_hit = 0
var hp = 100
var timer

func _on_Area2D_body_enter( body ):
	if (body.get_name() == "Player"):
		#get_tree().set_pause(true)
		get_node("AnimationPlayer").play("BattleBegin")
		global.BattleStart()

func _on_Area2D_body_exit( body ):
	get_tree().set_pause(false)
	global.BattleEnd()


func _on_Area2D_2_area_enter( area ):
	timer = get_node("KinematicBody2D/Damage/Timer")
	
	if (area.get_name() == "Weapon"):
		if (timer.get_time_left() <= 0.7):
			if (timer.get_time_left() == 0):
				hp -= new_hit
				new_hit = 0
			timer.start()
			new_hit += rand_range(1, 20)
			get_node("KinematicBody2D/Damage").set_text(str(round(new_hit)))
			get_node("KinematicBody2D/Damage/Anim").play("hit")
	
	if hp <= 0:
		global.add_stat(1)
		get_node("KinematicBody2D").queue_free()


func _on_ToWorldMap_body_enter( body ):
	if (body.get_name() == "Player"):
		Transition.fade_to("res://scenes/WorldMap.tscn")