extends Node2D

var pos_of_player = Vector2()

func _ready():
	set_process(true)
	
	#print(global.entry_point, " ", get_name())
	
	if get_name() == "FirstScene":
		if global.entry_point == 0:
			pos_of_player = Vector2(770, 0)
		if global.entry_point == 2:
			pos_of_player = Vector2(30, 360)
		if global.entry_point == 3:
			pos_of_player = Vector2(1450, 360)
		global.entry_point = 1
	
	if get_name() == "SecondScene":
		if global.entry_point == 1 or global.entry_point == 0:
			pos_of_player = Vector2(330, 80)
		if global.entry_point == 3:
			pos_of_player = Vector2(1000, 470)
		global.entry_point = 2
	
	if get_name() == "ThirdScene":
		if global.entry_point == 1 or global.entry_point == 0:
			pos_of_player = Vector2(950, 80)
		if global.entry_point == 2:
			pos_of_player = Vector2(150, 400)
		global.entry_point = 3
	
	for node in get_tree().get_nodes_in_group('persistent'):
		node.set_pos(pos_of_player)



func _on_Area2D_1_body_enter(body):
	if (body.get_name() == "Player"):
		get_node("Gem1/Area2D_1/Trade").show()
		get_node("Gem1/Button1").show()

func _on_Area2D_1_body_exit(body):
	if (body.get_name() == "Player"):
		get_node("Gem1/Area2D_1/Trade").hide()
		get_node("Gem1/Button1").hide()
		get_node("HUDLayer/TabContainer").hide()

func _on_Area2D_3_body_enter(body):
	if (body.get_name() == "Player"):
		get_node("Gem3/Area2D_3/Trade").show()
		get_node("Gem3/Button3").show()

func _on_Area2D_3_body_exit(body):
	if (body.get_name() == "Player"):
		get_node("Gem3/Area2D_3/Trade").hide()
		get_node("Gem3/Button3").hide()
		get_node("HUDLayer/TabContainer").hide()



func _on_ToCityMap_body_enter( body ):
	if (body.get_name() == "Player"):
		#get_tree().change_scene("res://CityMap.tscn")
		Transition.fade_to("res://CityMap.tscn")

func _on_ToFirstScene_body_enter( body ):
	if (body.get_name() == "Player"):
		Transition.fade_to("res://FirstScene.tscn")

func _on_ToSecondScene_body_enter( body ):
	if (body.get_name() == "Player"):
		Transition.fade_to("res://SecondScene.tscn")

func _on_ToThirdScene_body_enter( body ):
	if (body.get_name() == "Player"):
		Transition.fade_to("res://ThirdScene.tscn")



func _on_ButtonTrade_pressed():
	get_node("HUDLayer/TabContainer").show()
