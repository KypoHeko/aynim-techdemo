extends KinematicBody2D

onready var HUD = get_tree().get_nodes_in_group("hud")[0]

func _ready():
	pass

func _on_Area2D_body_enter( body ):
	if (body.get_name() == "Player"):
		get_node("Area2D/Trading").show()
		get_node("Area2D/Trade").show()
		HUD.get_node("Action").show()
		HUD.get_node("Action/Label").set_text("Trade!")
		HUD.NPCname = get_name()

func _on_Area2D_body_exit( body ):
	if (body.get_name() == "Player"):
		get_node("Area2D/Trading").hide()
		get_node("Area2D/Trade").hide()
		get_node("CanvasLayer/TradeWindow").hide()
		HUD.get_node("Action").hide()

func _on_Trading_pressed():
	get_node("CanvasLayer/TradeWindow").renew_items()
	get_node("CanvasLayer/TradeWindow").show()
	
	if get_parent().get_name() == "FirstScene":
		global.firstscene[int(get_name().substr(8, 1))] = 1
	if get_parent().get_name() == "SecondScene":
		global.secondscene[int(get_name().substr(8, 1))] = 1
	if get_parent().get_name() == "ThirdScene":
		global.thirdscene[int(get_name().substr(8, 1))] = 1