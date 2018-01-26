extends TabContainer

const ITEMS_TEXT = "res://saves/items.json"

onready var itemlist = get_node("Equip/Inventory")
onready var questlist = get_node("QuestsList/Tree")
var item = ""
var active_quests
var completed_quests
var forunequip = ""

func _ready():
	#настройки для инвентаря
	itemlist.set_max_columns(7)
	itemlist.set_fixed_icon_size(Vector2(64,64))
	#обновить список квестов
	renew_quests()
	#загрузить список предметов
	loaditems()
	
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
	get_node("QuestsList/Quest").play()
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
func loaditems():
	itemlist.clear()
	
	var save_file = File.new()
	if !save_file.file_exists(ITEMS_TEXT):
		return
	
	var data = {}
	save_file.open(ITEMS_TEXT, File.READ)
	data.parse_json(save_file.get_as_text())
	
	for i in global.player_inv:
		itemlist.add_icon_item(load(data[str(i)]["icon"]))



#постоянное обновление статов
func _process(delta):
	get_node("Status/Panel/LevelVal").set_text(str(global.battle_level))
	get_node("Status/Panel/ExpVal").set_text(str(global.exp_points))
	get_node("Status/Panel/MoneyVal").set_text(str(global.money))



#выбросить предмет
func _on_Drop_pressed():
	if str(item) != "":
		var player = get_tree().get_nodes_in_group('persistent')[0]
		var add_drop = preload("res://scenes/Drop.tscn")
		var drop = add_drop.instance()
		#выбросить в координатах персонажа
		drop.set_pos(player.get_pos())
		#выбросить предмет
		drop.id[0] = global.player_inv[item]
		#удалить из инвентаря
		global.delete_item(global.player_inv[item])
		#обновить список
		loaditems()
		item = ""
		get_parent().get_parent().add_child(drop)

#экипируем шмоты
func _on_Use_pressed():
	if str(item) != "":
		var inventory = global.player_inv[item]
		var lefthand = get_node("Equip/LeftHand")
		var equip = global.player_equip
		
		#если что-то экипировано, то вернуть вещь в инвентарь
		if str(equip["LeftHand"]) != "":
			global.player_inv.append(equip["LeftHand"])
		#экипируем вещь
		equip[lefthand.get_name()] = inventory
		
		lefthand.clear()
		lefthand.add_icon_item(load(loadin(inventory)))
		
		#удалить из инвентаря
		global.delete_item(inventory)
		#обновить список
		loaditems()
		item = ""

#снимаем вещи
func _on_Uneq_pressed():
	#если мы выбрали какую-либо часть тела
	if forunequip != "":
		var unequip = get_node("Equip/" + forunequip)
		#добавляем в инвентарь вещь
		global.player_inv.append(global.player_equip[forunequip])
		#очищаем все данные чтобы избежать клонирования
		unequip.clear()
		global.player_equip[forunequip] = ""
		forunequip = ""
		#обновляем инвентарь
		loaditems()

#Слишком тяжелая функция! Необходимо переделать в будущем!
func loadin(id):
	var save_file = File.new()
	if !save_file.file_exists(ITEMS_TEXT):
		return
	
	var data = {}
	save_file.open(ITEMS_TEXT, File.READ)
	data.parse_json(save_file.get_as_text())
	
	return data[str(id)]["icon"]

func _on_Inventory_item_selected( index ):
	item = index
	forunequip = ""


func _on_LeftHand_item_selected( index ):
	forunequip = "LeftHand"
func _on_RightHand_item_selected( index ):
	forunequip = "RightHand"
func _on_Legs_item_selected( index ):
	forunequip = "Legs"
func _on_Feets_item_selected( index ):
	forunequip = "Feets"
func _on_Body_item_selected( index ):
	forunequip = "Body"
func _on_Head_item_selected( index ):
	forunequip = "Head"