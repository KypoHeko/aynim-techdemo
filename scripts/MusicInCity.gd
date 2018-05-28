extends StreamPlayer

var musicname

func _ready():
	pass
	
func fade_it():
	get_node("AnimationPlayer").play("fade")

func fade_in():
	get_node("AnimationPlayer").play("fade_in")
	
func change(music):
	musicname = "res://music/" + music + ".ogg"
	if (get_stream().get_path() != musicname):
		MusicInCity.set_stream(load(musicname))
		MusicInCity.play()