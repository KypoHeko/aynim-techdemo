extends Node2D

func _on_Area2D_body_enter( body ):
	if (body.get_name() == "Player"):
		#get_tree().set_pause(true)
		get_node("Label").show()
		get_node("Label1").show()
		get_node("HUDLayer/BarPanel").show()
		

func _on_Area2D_body_exit( body ):
	#get_tree().set_pause(false)
	get_node("Label").hide()
	get_node("Label1").hide()
	get_node("HUDLayer/BarPanel").hide()
