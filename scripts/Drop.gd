extends Area2D

#путь до файла с данными по предметам
const ITEMS_TEXT = "res://saves/items.json"

onready var HUD = get_tree().get_nodes_in_group("hud")[0]
onready var LOOT = get_tree().get_nodes_in_group('loot')[0]

var id = [0]
var move_x = 0
var move_y = 0
var move

func _ready():
	randomize()
	move_x = rand_range(-100, 100)
	move_y = rand_range(-100, 100)
	move = get_pos() + Vector2(move_x, move_y)
	#для отладки
	#id = [int(round(rand_range(0, 10)))]
	
	get_node("Sprite").set_texture(load(loaditems(id)))
	set_fixed_process(true)

func _fixed_process(delta):
	set_pos(get_pos().linear_interpolate(move, 0.05))
	
	if id == []:
		queue_free()
	
	#if global.dictforloot.has(get_name()):
	#	if global.dictforloot[get_name()] == []:
	#		queue_free()



#Слишком тяжелая функция! Необходимо переделать в будущем!
func loaditems(id):
	var save_file = File.new()
	if !save_file.file_exists(ITEMS_TEXT):
		return
	
	var data = {}
	save_file.open(ITEMS_TEXT, File.READ)
	data.parse_json(save_file.get_as_text())
	
	return data[str(id[0])]["icon"]


func _on_Drop_body_enter( body ):
	if (body.get_name() == "Player"):
		global.dictforloot[get_name()] = id
		#LOOT.loot = global.dictforloot.values()
		#LOOT.renew_items()
		
		LOOT.loot = id
		
		HUD.get_node("Action").show()
		HUD.get_node("Action/Label").set_text("Loot!")

func _on_Drop_body_exit( body ):
	if (body.get_name() == "Player"):
		
		global.dictforloot.erase(get_name())
		#LOOT.loot = global.dictforloot.values()
		#LOOT.renew_items()
		
		#if global.dictforloot.empty():
		#	print("Clear!")
		
		HUD.get_node("Action").hide()
		HUD.get_node("Loot").hide()