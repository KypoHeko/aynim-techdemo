extends Node2D

func _ready():
	MusicInCity.change("battlemap")

func _on_ToWorldMap_body_enter( body ):
	if (body.get_name() == "Player"):
		Transition.fade_to("res://scenes/WorldMap.tscn")

func _on_Cutscene_body_enter( body ):
	get_tree().get_nodes_in_group("hud")[0].camera_pos = get_node("AnimatedSprite").get_pos() - get_tree().get_nodes_in_group('persistent')[0].get_pos()
	get_tree().get_nodes_in_group("hud")[0].just_talk("watchout")

func _on_Button_pressed():
	get_node("StartBattle").play("BattleBegin")