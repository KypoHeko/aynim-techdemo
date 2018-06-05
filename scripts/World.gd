extends Node2D

var pos_of_player = Vector2()

func _ready():
	set_process(true)
	MusicInCity.change("citymusic")
	
	if get_name() == "FirstScene":
		#зацикленный звук фонтана
		var fountain = get_node("FountainSound").get_sample_library().get_sample("fountain")
		fountain.set_loop_format(fountain.LOOP_FORWARD)
		fountain.set_loop_begin(0)
		fountain.set_loop_end(fountain.get_length())
		
		get_node("FountainSound").play("fountain")
		
		if global.entry_point == 0:
			pos_of_player = Vector2(770, 0)
		if global.entry_point == 2:
			pos_of_player = Vector2(30, 360)
		if global.entry_point == 3:
			pos_of_player = Vector2(1450, 360)
		if global.entry_point == 4:
			pos_of_player = Vector2(770, 800)
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
	
	if get_name() == "FourthScene":
		if global.entry_point == 1 or global.entry_point == 0:
			pos_of_player = Vector2(250, 150)
		global.entry_point = 4
		
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

func _on_ToFourthScene_body_enter( body ):
	if (body.get_name() == "Player"):
		Transition.fade_to("res://scenes/FourthScene.tscn")
