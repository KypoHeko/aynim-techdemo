extends StreamPlayer

func _ready():
	pass
	
func fade_it():
	get_node("AnimationPlayer").play("fade")

func fade_in():
	get_node("AnimationPlayer").play("fade_in")
	
func change(music):
	MusicInCity.set_stream(load("res://music/" + music + ".ogg"))
	MusicInCity.play()