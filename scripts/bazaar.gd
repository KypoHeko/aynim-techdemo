extends TabContainer

#путь до файла с данными по предметам
const ITEMS_TEXT = "res://saves/items.json"

#подгружаем таблицы для магазина и инвентаря
onready var buyitemlist = get_node("Buy/ItemList")
onready var sellitemlist = get_node("Sell/ItemList1")

#временная переменная в которой хранится индекс нужного предмета для подгрузки
var temp
#массив предметов у продавца
var merch = [1,2,3,6,7,8]
#переменные для выбора нужного предемта в таблицах
var buy_item = ""
var sell_item = ""
#стоимость
var cost

func _ready():
	#задание кол-ва столбцов и размеров иконок
	buyitemlist.set_max_columns(4)
	buyitemlist.set_fixed_icon_size(Vector2(64,64))
	sellitemlist.set_max_columns(4)
	sellitemlist.set_fixed_icon_size(Vector2(64,64))
	#загрузка в таблицы предметов
	loaditems(merch, "Buy")
	loaditems(global.player_inv, "Sell")
	
	renew_items()
	
	set_process(true)



func renew_items():
	buyitemlist.clear()
	sellitemlist.clear()
	loaditems(global.player_inv, "Sell")
	loaditems(merch, "Buy")



#если выбран предмет для купли
func _on_ItemList_item_selected( index ):
	#индекс покупаемого предмета
	buy_item = index
	#загружаем данные о предмете
	loaditems(index, "Buy")

#если выбран предмет для продажи
func _on_ItemList1_item_selected( index ):
	#индекс продаваемого предмета
	sell_item = index
	#загружаем данные о предмете
	loaditems(index, "Sell")


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
		if string == "Buy":
			for j in index:
				buyitemlist.add_icon_item(load(data[str(j)]["icon"]))
		if string == "Sell":
			for j in index:
				sellitemlist.add_icon_item(load(data[str(j)]["icon"]))
	#если передается переменная в функцию то загружаем данные о предмете
	else:
		if string == "Buy":
			temp = str(merch[index])
		if string == "Sell":
			temp = str(global.player_inv[index])
		get_node(string + "/Name").set_text(data[temp]["name"])
		get_node(string + "/Cost").set_text("Cost: " + data[temp]["cost"])
		cost = int(data[temp]["cost"])
		get_node(string + "/Description").set_text(data[temp]["description"])

#функция купли
func _on_Buy_pressed():
	if str(buy_item) != "":
		#добавляем индекс предмета персонажу
		global.add_new_item(merch[buy_item])
		#обновляем таблицу купли
		renew_items()
		#вычитаем из глобальной переменной стоимость
		global.money -= cost
	
	#необходимая мера
	buy_item = ""
	cost = 0

#функция продажи
func _on_Sell_pressed():
	if str(sell_item) != "":
		#удаляем индекс предмета у персонажа
		global.delete_item(global.player_inv[sell_item])
		#обновляем таблицу продажи
		renew_items()
		#добавляем в глобальную переменную стоимость
		global.money += cost
	
	#необходимая мера чтобы все не продать и не выйти за границы массива
	sell_item = ""
	cost = 0



#закрыть окно магазина
func _on_Exit_pressed():
	hide()

#загрузка кол-ва денег
func _process(delta):
	get_node("Buy/YourMoney").set_text("Your money: " + str(global.money))
	get_node("Sell/YourMoney").set_text("Your money: " + str(global.money))