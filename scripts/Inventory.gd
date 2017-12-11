extends TabContainer

const ITEMS_TEXT = "res://saves/items.json"

onready var itemlist = get_node("Equip/ItemList")
onready var questlist = get_node("QuestsList/Tree")
var active_quests
var completed_quests

func _ready():
	#настройки для инвентаря
	itemlist.set_max_columns(7)
	itemlist.set_fixed_icon_size(Vector2(64,64))
	
	#обновить список квестов
	renew_quests()
	
	#загрузить спискок предметов
	for i in global.player_inv:
		loaditems(i)
	
	set_process(true)

#выполняем изменения при изменении квестов
func renew_quests():
	questlist.clear()
	
	#настройки для меню квестов
	var root = questlist.create_item()
	questlist.set_hide_root(true)
	
	active_quests = questlist.create_item(root)
	active_quests.set_text(0, "Active")
	completed_quests = questlist.create_item(root)
	completed_quests.set_text(0, "Completed")
	
	var quest_data
	#изменения в активные квесты
	for i in global.player_quests:
		quest_data = global.loadquest(i)
		
		#имя квеста
		var sect = questlist.create_item(active_quests)
		sect.set_text(0, quest_data['name'])
		#описание
		var descr = questlist.create_item(sect)
		descr.set_text(0, quest_data['description'])
		#награда
		var reward = questlist.create_item(sect)
		var temp = "Reward: " + quest_data['money'] + ". EXP: " + quest_data['EXP']
		reward.set_text(0, temp)
	
	#изменения в выполненные квесты
	for i in global.player_c_quests:
		quest_data = global.loadquest(i)
		
		var sect = questlist.create_item(completed_quests)
		sect.set_text(0, quest_data['name'])
		var descr = questlist.create_item(sect)
		descr.set_text(0, quest_data['description'])
	
	#скрыть древо выполненных квестов
	completed_quests.set_collapsed(true)

#добавляем в журнал новый квест
func add_quest(data):
	#имя квеста
	var sect = questlist.create_item(active_quests)
	sect.set_text(0, data['name'])
	#описание
	var descr = questlist.create_item(sect)
	descr.set_text(0, data['description'])
	#награда
	var reward = questlist.create_item(sect)
	var temp = "Reward: " + data['money'] + ". EXP: " + data['EXP']
	reward.set_text(0, temp)



#загружаем предметы в инвентарь
func loaditems(index):
	var save_file = File.new()
	if !save_file.file_exists(ITEMS_TEXT):
		return
	
	var data = {}
	save_file.open(ITEMS_TEXT, File.READ)
	data.parse_json(save_file.get_as_text())
	
	itemlist.add_icon_item(load(data[str(index)]["icon"]))

#удаляем предметы из инвентаря
func deleteitem(index):
	itemlist.remove_item(index)



#постоянное обновление статов
func _process(delta):
	get_node("Status/Panel/LevelVal").set_text(str(global.battle_level))
	get_node("Status/Panel/ExpVal").set_text(str(global.exp_points))
	get_node("Things/ItemList/ColItemsVal").set_text(str(global.colitems))
	get_node("Status/Panel/MoneyVal").set_text(str(global.money))