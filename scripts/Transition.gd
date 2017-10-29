extends CanvasLayer

var path = ""

func fade_to(tscn_path):
	path = tscn_path
	get_node("AnimationPlayer").play("fade")

func change_scene():
	get_tree().change_scene(path)