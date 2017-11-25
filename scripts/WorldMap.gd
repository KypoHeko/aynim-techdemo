extends Node2D

func _ready():
	MusicInCity.change("mapmusic")

func _on_TextureButton_pressed():
	Transition.fade_to("res://scenes/CityMap.tscn")

func _on_TextureButton_2_pressed():
	Transition.fade_to("res://scenes/BattleMap.tscn")
	MusicInCity.stop()
