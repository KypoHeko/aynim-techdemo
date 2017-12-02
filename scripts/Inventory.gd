extends TabContainer

var itemlist

func _ready():
	itemlist = get_node("Equip/ItemList")
	itemlist.set_max_columns(7)
	itemlist.set_fixed_icon_size(Vector2(64,64))
	itemlist.add_icon_item(load("res://img/icons/gem1.png"))
	itemlist.add_icon_item(load("res://img/icons/gem3.png"))
	itemlist.add_icon_item(load("res://img/icons/icon.png"))
	set_process(true)

func _process(delta):
	get_node("Status/Panel/LevelVal").set_text(str(global.battle_level))
	get_node("Status/Panel/ExpVal").set_text(str(global.exp_points))
	get_node("Things/ItemList/ColItemsVal").set_text(str(global.colitems))
	get_node("Status/Panel/MoneyVal").set_text(str(global.money))