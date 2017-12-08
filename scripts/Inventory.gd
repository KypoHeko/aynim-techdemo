extends TabContainer

const ITEMS_TEXT = "res://saves/items.json"

onready var itemlist = get_node("Equip/ItemList")
onready var questlist = get_node("QuestList/Tree")

func _ready():
	itemlist.set_max_columns(7)
	itemlist.set_fixed_icon_size(Vector2(64,64))
	
	for i in global.player_inv:
		loaditems(i)
	set_process(true)


func loaditems(index):
	var save_file = File.new()
	if !save_file.file_exists(ITEMS_TEXT):
		return
	
	var data = {}
	save_file.open(ITEMS_TEXT, File.READ)
	data.parse_json(save_file.get_as_text())
	
	itemlist.add_icon_item(load(data["id" + str(index)]["icon"]))

func deleteitem(index):
	itemlist.remove_item(index)


func _process(delta):
	get_node("Status/Panel/LevelVal").set_text(str(global.battle_level))
	get_node("Status/Panel/ExpVal").set_text(str(global.exp_points))
	get_node("Things/ItemList/ColItemsVal").set_text(str(global.colitems))
	get_node("Status/Panel/MoneyVal").set_text(str(global.money))
