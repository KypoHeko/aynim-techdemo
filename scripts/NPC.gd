extends KinematicBody2D


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


var text
var count = 0
func _on_Talk_pressed():
	var HUD = get_tree().get_nodes_in_group("hud")[0]
	
	if "firstquest" in global.player_quests:
		print("Nice!")
	
	text = global.loadtext("firstquest")
	HUD.get_node("CloudText").show()
	HUD.get_node("CloudText/Text").set_text(text[count])
	count += 1
	if (count == (text.size() - 1)):
		HUD.get_node("CloudText/ctOK").show()
		HUD.get_node("CloudText/ctNo").show()
	if (count > (text.size() - 1)):
		count = 0
		global.dialog("", "")
