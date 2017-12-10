extends KinematicBody2D

onready var HUD = get_tree().get_nodes_in_group("hud")[0]

func _ready():
	pass

func _on_Area2D_body_enter( body ):
	if (body.get_name() == "Player"):
		get_node("Area2D/Talk").show()
		get_node("Area2D/Quest").show()

func _on_Area2D_body_exit( body ):
	if (body.get_name() == "Player"):
		get_node("Area2D/Talk").hide()
		get_node("Area2D/Quest").hide()
		HUD.close_dialog("", "")

func _on_Talk_pressed():
	HUD.quest_talk(get_name())