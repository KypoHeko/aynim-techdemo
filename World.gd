extends Node2D

func _on_Area2D_1_body_enter(body):
	if (body.get_name() == "Player"):
		get_node("Gem1/Area2D_1/Trade").show()
		get_node("Gem1/Button1").show()

func _on_Area2D_1_body_exit(body):
	if (body.get_name() == "Player"):
		get_node("Gem1/Area2D_1/Trade").hide()
		get_node("Gem1/Button1").hide()

func _on_Area2D_3_body_enter(body):
	if (body.get_name() == "Player"):
		get_node("Gem3/Area2D_3/Trade").show()
		get_node("Gem3/Button3").show()

func _on_Area2D_3_body_exit(body):
	if (body.get_name() == "Player"):
		get_node("Gem3/Area2D_3/Trade").hide()
		get_node("Gem3/Button3").hide()



func _on_ToCityMap_body_enter( body ):
	if (body.get_name() == "Player"):
		get_tree().change_scene("res://CityMap.tscn")
		print(global.entry_point)

func _on_ToFirstScene_body_enter( body ):
	if (body.get_name() == "Player"):
		get_tree().change_scene("res://FirstScene.tscn")
		print(global.entry_point)

func _on_ToSecondScene_body_enter( body ):
	if (body.get_name() == "Player"):
		get_tree().change_scene("res://SecondScene.tscn")
		print(global.entry_point)

func _on_ToThirdScene_body_enter( body ):
	if (body.get_name() == "Player"):
		get_tree().change_scene("res://ThirdScene.tscn")
		print(global.entry_point)
