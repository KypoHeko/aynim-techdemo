extends Node2D

func _ready():
	global.entry_point = 0
	
	for i in range(global.firstscene.size()):
		if global.firstscene[i] == 1:
			get_node("Button/Merchant" + str(i)).show()
	for i in range(global.secondscene.size()):
		if global.secondscene[i] == 1:
			get_node("Button1/Merchant" + str(i)).show()
	for i in range(global.thirdscene.size()):
		if global.thirdscene[i] == 1:
			get_node("Button2/Merchant" + str(i)).show()

func _on_Button_pressed():
	Transition.fade_to("res://scenes/FirstScene.tscn")

func _on_Button1_pressed():
	Transition.fade_to("res://scenes/SecondScene.tscn")

func _on_Button2_pressed():
	Transition.fade_to("res://scenes/ThirdScene.tscn")

func _on_Button3_pressed():
	Transition.fade_to("res://scenes/WorldMap.tscn")

func _on_Merchant_pressed():
	get_node("CanvasLayer/bazaar").renew_items()
	get_node("CanvasLayer/bazaar").show()
