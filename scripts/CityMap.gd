extends Node2D

func _ready():
	global.entry_point = 0

func _on_Button_pressed():
	Transition.fade_to("res://FirstScene.tscn")

func _on_Button1_pressed():
	Transition.fade_to("res://SecondScene.tscn")

func _on_Button2_pressed():
	Transition.fade_to("res://ThirdScene.tscn")

func _on_Button3_pressed():
	Transition.fade_to("res://WorldMap.tscn")