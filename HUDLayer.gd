extends CanvasLayer

const MOTION_SPEED = 300

func _ready():
	Input.action_release("move_down")
	Input.action_release("move_up")
	Input.action_release("move_left")
	Input.action_release("move_right")

func _on_Pause_pressed():
	get_tree().set_pause(true)
	print("Pause")

func _on_Unpause_pressed():
	get_tree().set_pause(false)
	print("Unpause")

var t = false
func _on_Menu_pressed():
	if t == false:
		get_node("Panel").show()
		t = not t
	else:
		get_node("Panel").hide()
		t = not t


func _on_Resume_pressed():
	get_node("Panel").hide()
	t = false

func _on_Options_pressed():
	get_node("Panel 2").show()

func _on_Exit_to_main_menu_pressed():
	print("To main menu")
	get_tree().change_scene("res://MainMenu.tscn")

func _on_Exit_pressed():
	get_tree().quit()

func _on_OK_pressed():
	get_node("Panel 2").hide()


func _on_ButtonUp_button_down():
	Input.action_press("move_up")
func _on_ButtonUp_button_up():
	Input.action_release("move_up")

func _on_ButtonRight_button_down():
	Input.action_press("move_right")
func _on_ButtonRight_button_up():
	Input.action_release("move_right")

func _on_ButtonDown_button_down():
	Input.action_press("move_down")
func _on_ButtonDown_button_up():
	Input.action_release("move_down")

func _on_ButtonLeft_button_down():
	Input.action_press("move_left")
func _on_ButtonLeft_button_up():
	Input.action_release("move_left")
	

const SAVE_PATH = "res://saves/save.json"
func _on_Save_pressed():
	var save_dict = {}
	var nodes_to_save = get_tree().get_nodes_in_group('persistent')
	for node in nodes_to_save:
		save_dict[node.get_path()] = node.save()
	
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	save_file.store_line(save_dict.to_json())
	save_file.close()

func _on_Load_pressed():
	var save_file = File.new()
	if not save_file.file_exists(SAVE_PATH):
		return
	
	save_file.open(SAVE_PATH, File.READ)
	var data = {}
	data.parse_json(save_file.get_as_text())
	
	for node_path in data.keys():
		var node = get_node(node_path)
		
		for attribute in data[node_path]:
			if attribute == "scene":
				var loaded_scene = "res://" + data[node_path]['scene'] + ".tscn"
				get_tree().change_scene(loaded_scene)
				print(loaded_scene)
			
			#if attribute == "pos":
				#node.set_pos(Vector2(data[node_path]['pos']['x'], data[node_path]['pos']['y']))