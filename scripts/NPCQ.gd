extends KinematicBody2D

onready var HUD = get_tree().get_nodes_in_group("hud")[0]

func _ready():
	pass

func _on_Area2D_body_enter( body ):
	if (body.get_name() == "Player"):
		get_node("Area2D/Quest").show()
		HUD.get_node("Action").show()
		HUD.get_node("Action/Label").set_text("Quest!")
		HUD.NPCname = get_name()

func _on_Area2D_body_exit( body ):
	if (body.get_name() == "Player"):
		get_node("Area2D/Quest").hide()
		HUD.close_dialog("", "")
		HUD.get_node("Action").hide()
