extends TabContainer

func _ready():
	set_process(true)

func _process(delta):
	get_node("Status/Panel/LevelVal").set_text(str(global.battle_level))
	get_node("Status/Panel/ExpVal").set_text(str(global.exp_points))
	get_node("Things/ItemList/ColItemsVal").set_text(str(global.colitems))