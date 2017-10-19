extends Node2D


func _on_Area2D_body_enter( body ):
	if (body.get_name() == "Player"):
		get_node("Label").show()
		get_node("Label1").show()
		get_node("HUDLayer/TextureProgress").show()
		get_node("HUDLayer/TextureProgress1").show()
		get_node("HUDLayer/TextureProgress2").show()
		get_tree().set_pause(true)
		

func _on_Area2D_body_exit( body ):
		get_tree().set_pause(false)
		get_node("HUDLayer/TextureProgress").hide()
		get_node("HUDLayer/TextureProgress1").hide()
		get_node("HUDLayer/TextureProgress2").hide()
