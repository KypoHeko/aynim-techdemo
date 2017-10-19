extends Node2D


func _on_TextureButton_pressed():
	get_tree().change_scene("res://CityMap.tscn")


func _on_TextureButton_2_pressed():
	get_tree().change_scene("res://BattleMap.tscn")
