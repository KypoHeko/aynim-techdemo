extends KinematicBody2D

func _ready():
	pass

func _on_Area2D_body_enter( body ):
	if (body.get_name() == "Player"):
		get_node("Area2D/Trading").show()
		get_node("Area2D/Trade").show()

func _on_Area2D_body_exit( body ):
	if (body.get_name() == "Player"):
		get_node("Area2D/Trading").hide()
		get_node("Area2D/Trade").hide()
		get_node("CanvasLayer/TradeWindow").hide()

func _on_Trading_pressed():
	get_node("CanvasLayer/TradeWindow").show()
