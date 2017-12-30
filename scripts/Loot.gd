extends Panel

#путь до файла с данными по предметам
const ITEMS_TEXT = "res://saves/items.json"

#подгружаем таблицы для магазина и инвентаря
onready var lootitemlist = get_node("ItemList")
onready var invitemlist = get_node("ItemList1")
var loot = []
var lootitem = ""
var invitem = ""

func _ready():
	lootitemlist.set_max_columns(4)
	lootitemlist.set_fixed_icon_size(Vector2(64,64))
	invitemlist.set_max_columns(4)
	invitemlist.set_fixed_icon_size(Vector2(64,64))
	renew_items()

func renew_items():
	lootitemlist.clear()
	invitemlist.clear()
	loaditems(global.player_inv, "Drop")
	loaditems(loot, "Pick")


#Слишком тяжелая функция! Необходимо переделать в будущем!
func loaditems(index, string):
	var save_file = File.new()
	if !save_file.file_exists(ITEMS_TEXT):
		return
	
	var data = {}
	save_file.open(ITEMS_TEXT, File.READ)
	data.parse_json(save_file.get_as_text())
	
	#если передается массив в функцию то загружаем предметы в таблицы
	if typeof(index) == TYPE_ARRAY:
		if string == "Pick":
			for j in index:
				lootitemlist.add_icon_item(load(data[str(j)]["icon"]))
		if string == "Drop":
			for j in index:
				invitemlist.add_icon_item(load(data[str(j)]["icon"]))


#забираем все предметы
func _on_Butto_pressed():
	global.player_inv += loot
	loot.clear()
	renew_items()

#подбираем предмет
func _on_Button_pressed():
	if str(lootitem) != "":
		global.player_inv.append(loot[lootitem])
		loot.erase(loot[lootitem])
		#обновляем таблицы
		renew_items()
	
	#необходимая мера
	lootitem = ""

#сбрасываем предмет
func _on_Button1_pressed():
	if str(invitem) != "":
		loot.append(global.player_inv[invitem])
		global.player_inv.erase(global.player_inv[invitem])
		#обновляем таблицы
		renew_items()
	
	#необходимая мера чтобы все не скинуть и не выйти за границы массива
	invitem = ""

#закрыть окно магазина
func _on_Exit_pressed():
	hide()

func _on_ItemList_item_selected( index ):
	lootitem = index

func _on_ItemList1_item_selected( index ):
	invitem = index