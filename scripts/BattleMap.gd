extends Node2D

var new_hit = 0
var hp = 100
var timer

func _ready():
	pass

func _on_ToWorldMap_body_enter( body ):
	if (body.get_name() == "Player"):
		Transition.fade_to("res://scenes/WorldMap.tscn")