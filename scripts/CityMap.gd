extends Node2D

func _ready():
	global.entry_point = 0

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
