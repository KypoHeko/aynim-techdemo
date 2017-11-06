extends Node2D

func _on_Area2D_body_enter( body ):
	if (body.get_name() == "Player"):
		get_tree().set_pause(true)
		get_node("AnimationPlayer").play("BattleBegin")
		get_node("HUDLayer/BarPanel").show()
		global.BattleStart()

func _on_Area2D_body_exit( body ):
	get_tree().set_pause(false)
	get_node("HUDLayer/BarPanel").hide()
	global.BattleEnd()
