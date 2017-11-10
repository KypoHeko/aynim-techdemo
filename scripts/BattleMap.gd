extends Node2D

var hp = 100

func _on_Area2D_body_enter( body ):
	if (body.get_name() == "Player"):
		#get_tree().set_pause(true)
		get_node("AnimationPlayer").play("BattleBegin")
		get_node("HUDLayer/BarPanel").show()
		global.BattleStart()

func _on_Area2D_body_exit( body ):
	get_tree().set_pause(false)
	get_node("HUDLayer/BarPanel").hide()
	global.BattleEnd()

func _on_Area2D_2_area_enter( area ):
	if (area.get_name() == "Weapon"):
		hp -= 20
		get_node("KinematicBody2D/Label").set_text(str(hp))
		get_node("KinematicBody2D/Label/Anim").play("hit")
	if hp <= 0:
		get_node("KinematicBody2D").queue_free()



func _on_ToWorldMap_body_enter( body ):
	if (body.get_name() == "Player"):
		Transition.fade_to("res://WorldMap.tscn")