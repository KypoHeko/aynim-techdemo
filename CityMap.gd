extends Node2D

func _ready():
	global.entry_point = 0


func _on_Button_pressed():
	get_tree().change_scene("res://FirstScene.tscn")

func _on_Button1_pressed():
	get_tree().change_scene("res://SecondScene.tscn")

func _on_Button2_pressed():
	get_tree().change_scene("res://ThirdScene.tscn")

func _on_Button3_pressed():
	get_tree().change_scene("res://WorldMap.tscn")