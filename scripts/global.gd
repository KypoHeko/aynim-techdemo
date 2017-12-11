extends Node

onready var HUD = get_tree().get_nodes_in_group("hud")[0]
onready var INV = get_tree().get_nodes_in_group('inv')[0]

var entry_point = 0

var money = 250
var colitems = 0
var battle_level = 1
var exp_points = 1
var fib_a = 1
var fib_b = 2

var player_inv = [1, 1, 1]
var player_quests = []
var player_c_quests = []

const CLOUD_TEXT = "res://saves/cloudtext.json"
const SAVE_PATH = "res://saves/save.json"
const QUEST_PATH = "res://saves/quests.json"

#сброс передвижения при загрузке новой сцены
func input_release():
	Input.action_release("move_down")
	Input.action_release("move_up")
	Input.action_release("move_left")
	Input.action_release("move_right")


#добавляем опыт и повышаем опыт, наблюдается в инвентаре
func add_stat(i):
	exp_points += i
	while (exp_points >= fib_b):
		battle_level += 1
		fib_b += fib_a
		fib_a = fib_b - fib_a

#функция для начала битвы
func BattleStart():
	input_release()
	HUD.get_node("JoystickPanel").hide()
	HUD.get_node("JoystickPanel1").show()
	HUD.get_node("BarPanel").show()
	print("BattleStart!")

#функция для конца битвы
func BattleEnd():
	input_release()
	HUD.get_node("JoystickPanel").show()
	HUD.get_node("JoystickPanel1").hide()
	HUD.get_node("BarPanel").hide()
	print("BattleEnd!")



#сохраняем игру
func savegame():
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	var savenodes = get_tree().get_nodes_in_group('persistent')[0]
	var save_dict = savenodes.save()
	save_file.store_line(save_dict.to_json())
	save_file.close()

#загружаем игру
func loadgame():
	var save_file = File.new()
	if !save_file.file_exists(SAVE_PATH):
		return
	
	var data = {}
	save_file.open(SAVE_PATH, File.READ)
	data.parse_json(save_file.get_as_text())
	
	for i in data.keys():
		#загрузка сцены
		if i == "scene":
			global.entry_point = 0
			var loaded_scene = "res://scenes/" + data[i] + ".tscn"
			Transition.fade_to(loaded_scene)
		
		#костыли для загрузки положения
		var tmr = Timer.new()
		tmr.set_wait_time(1.05)
		tmr.set_one_shot(true)
		self.add_child(tmr)
		
		#загрузка положения на сцене
		if i == "pos":
			tmr.start()
			yield(tmr, "timeout")
			var savenodes = get_tree().get_nodes_in_group('persistent')
			var loaded_pos = Vector2(data[i]['x'], data[i]['y'])
			savenodes[0].set_pos(loaded_pos)
		
		if i == "money":
			global.money = data[i]
			
		if i == "inventory":
			global.player_inv = data[i]
		
		if i == "quests":
			global.player_quests = data[i]

#загружаем текст в облако
func loadtext(txt):
	var save_file = File.new()
	if !save_file.file_exists(CLOUD_TEXT):
		return
	
	var data = {}
	save_file.open(CLOUD_TEXT, File.READ)
	data.parse_json(save_file.get_as_text())
	
	for i in data.keys():
		if i == txt:
			return data[i]

#загружаем данные квеста в инвентарь
func loadquest(id_quest):
	var save_file = File.new()
	if !save_file.file_exists(QUEST_PATH):
		return
	
	var data = {}
	save_file.open(QUEST_PATH, File.READ)
	data.parse_json(save_file.get_as_text())
	
	for i in data.keys():
		if i == id_quest:
			return data[i]


#завершаем квест
func quest_completed():
	var quest_data = loadquest(HUD.id_quest)
	if int(quest_data['need_id']) in player_inv:
		#удаляем из активных квестов и добавляем в выполненные
		player_quests.erase(HUD.id_quest)
		player_c_quests.append(HUD.id_quest)
		INV.renew_quests()
		#удаляем предмет
		delete_item(int(quest_data['need_id']))
		#добавляем денег
		money += int(quest_data['money'])
		#добавляем опыта
		exp_points += int(quest_data['EXP'])



#добавляем предмет из магазина в инвентарь
func add_new_item(index):
	player_inv.append(index)
	INV.loaditems(index)

#продаем предмет из инвентаря в магазин
func delete_item(index):
	INV.deleteitem(player_inv.find(index))
	player_inv.erase(index)