extends TabContainer

func _ready():
	pass

func _on_Exit_pressed():
	var x = get_node(".").hide()
	print(x)
