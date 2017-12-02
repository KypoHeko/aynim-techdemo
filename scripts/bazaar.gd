extends TabContainer

const ITEMS_TEXT = "res://saves/items.json"

onready var buyitemlist = get_node("Buy/ItemList")
var temp

func _ready():
	buyitemlist.set_max_columns(6)
	buyitemlist.set_fixed_icon_size(Vector2(64,64))
	loaditems()


func loaditems():
	var save_file = File.new()
	if !save_file.file_exists(ITEMS_TEXT):
		return
	
	var data = {}
	save_file.open(ITEMS_TEXT, File.READ)
	data.parse_json(save_file.get_as_text())
	
	for i in data.keys():
		get_node("Buy/Name").set_text(data[i]["name"])
		get_node("Buy/Cost").set_text("Cost: " + data[i]["cost"])
		get_node("Buy/Description").set_text(data[i]["description"])
		buyitemlist.add_icon_item(load(data[i]["icon"]))


func _on_Exit_pressed():
	hide()
