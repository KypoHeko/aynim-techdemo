extends Node2D

var pos_of_player = Vector2()

func _ready():
	set_process(true)
	
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



func _on_ToCityMap_body_enter( body ):
	if (body.get_name() == "Player"):
		#get_tree().change_scene("res://CityMap.tscn")
		Transition.fade_to("res://scenes/CityMap.tscn")

func _on_ToFirstScene_body_enter( body ):
	if (body.get_name() == "Player"):
		Transition.fade_to("res://scenes/FirstScene.tscn")

func _on_ToSecondScene_body_enter( body ):
	if (body.get_name() == "Player"):
		Transition.fade_to("res://scenes/SecondScene.tscn")

func _on_ToThirdScene_body_enter( body ):
	if (body.get_name() == "Player"):
		Transition.fade_to("res://scenes/ThirdScene.tscn")



func _on_Green_body_enter( body ):
	if (body.get_name() == "Player"):
		global.colitems += 1
		print(get_name())
		get_node("Green1").queue_free()

func _on_Blue_body_enter( body ):
	if (body.get_name() == "Player"):
		global.colitems += 1
		get_node("Blue1").queue_free()



const CAMERA_SPEED = 500
func _on_Camera1_pressed():
	print(get_node("Player/Camera2D").get_pos())
	get_node("Player/Camera2D").move

func _on_Camera2_pressed():
	pass 