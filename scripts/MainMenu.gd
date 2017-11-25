extends VBoxContainer

func _on_Start_pressed():
	print("Start")
	get_tree().change_scene("res://scenes/FirstScene.tscn")

func _on_Options_pressed():
	print("Options")

func _on_Exit_pressed():
	get_tree().quit()
