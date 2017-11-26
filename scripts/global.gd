extends Node

var entry_point = 0

var battle_level = 1
var exp_points = 1
var fib_a = 1
var fib_b = 2

var colitems = 0

var cloud2 = "res://saves/cloudtext.json"
const SAVE_PATH = "res://saves/save.json"

func add_stat(i):
	exp_points += i
	while (exp_points >= fib_b):
		battle_level += 1
		fib_b += fib_a
		fib_a = fib_b - fib_a
		#print(exp_points, " ", fib_a, " ", fib_b)

func BattleStart():
	var icon = get_tree().get_nodes_in_group("hud")[0]
	icon.get_node("JoystickPanel").hide()
	icon.get_node("JoystickPanel1").show()
	icon.get_node("BarPanel").show()
	print("BattleStart!")

func BattleEnd():
	var icon = get_tree().get_nodes_in_group("hud")[0]
	icon.get_node("JoystickPanel").show()
	icon.get_node("JoystickPanel1").hide()
	icon.get_node("BarPanel").hide()
	print("BattleEnd!")


func savegame():
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	var savenodes = get_tree().get_nodes_in_group('persistent')
	for i in savenodes:
		var save_dict = i.save()
		save_file.store_line(save_dict.to_json())
	save_file.close()

func loadgame():
	var save_file = File.new()
	if !save_file.file_exists(SAVE_PATH):
		return
	
	var data = {}
	save_file.open(SAVE_PATH, File.READ)
	data.parse_json(save_file.get_as_text())
	
	for i in data.keys():
		if i == "scene":
			global.entry_point = 0
			var loaded_scene = "res://scenes/" + data[i] + ".tscn"
			Transition.fade_to(loaded_scene)
		
		var tmr = Timer.new()
		tmr.set_wait_time(1.05)
		tmr.set_one_shot(true)
		self.add_child(tmr)
		
		if i == "pos":
			tmr.start()
			yield(tmr, "timeout")
			var savenodes = get_tree().get_nodes_in_group('persistent')
			var loaded_pos = Vector2(data[i]['x'], data[i]['y'])
			savenodes[0].set_pos(loaded_pos)


func loadtext(txt):
	var save_file = File.new()
	if !save_file.file_exists(cloud2):
		return
	
	var data = {}
	save_file.open(cloud2, File.READ)
	data.parse_json(save_file.get_as_text())
	
	for i in data.keys():
		if i == txt:
			return data[i]