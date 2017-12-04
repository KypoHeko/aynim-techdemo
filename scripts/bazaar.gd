extends TabContainer

const ITEMS_TEXT = "res://saves/items.json"

onready var buyitemlist = get_node("Buy/ItemList")
onready var sellitemlist = get_node("Sell/ItemList1")

var temp
var merch = [1,2,3,6,7,8]
var buy_item = ""
var sell_item = ""

func _ready():
	buyitemlist.set_max_columns(4)
	buyitemlist.set_fixed_icon_size(Vector2(64,64))
	sellitemlist.set_max_columns(4)
	sellitemlist.set_fixed_icon_size(Vector2(64,64))
	get_node("Buy/YourMoney").set_text("Your money: " + str(global.money))
	loaditems(merch, "Buy")
	loaditems(global.player_inv, "Sell")

func _on_ItemList_item_selected( index ):
	buy_item = index
	loaditems(index, "Buy")

func _on_ItemList1_item_selected( index ):
	sell_item = index
	loaditems(index, "Sell")


func loaditems(index, string):
	var save_file = File.new()
	if !save_file.file_exists(ITEMS_TEXT):
		return
	
	var data = {}
	save_file.open(ITEMS_TEXT, File.READ)
	data.parse_json(save_file.get_as_text())
	
	if typeof(index) == TYPE_ARRAY:
		if string == "Buy":
			for j in index:
				buyitemlist.add_icon_item(load(data["id" + str(j)]["icon"]))
		if string == "Sell":
			for j in index:
				sellitemlist.add_icon_item(load(data["id" + str(j)]["icon"]))
	else:
		if string == "Buy":
			temp = "id" + str(merch[index])
		if string == "Sell":
			temp = "id" + str(global.player_inv[index])
		get_node(string + "/Name").set_text(data[temp]["name"])
		get_node(string + "/Cost").set_text("Cost: " + data[temp]["cost"])
		get_node(string + "/Description").set_text(data[temp]["description"])


func _on_Exit_pressed():
	hide()


func _on_Buy_pressed():
	global.add_new_item(merch[buy_item])

func _on_Sell_pressed():
	global.delete_item(global.player_inv[sell_item])
	sellitemlist.remove_item(sell_item)