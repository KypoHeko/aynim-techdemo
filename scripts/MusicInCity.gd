extends StreamPlayer

func _ready():
	pass
	
func fade_it():
	get_node("AnimationPlayer").play("fade")