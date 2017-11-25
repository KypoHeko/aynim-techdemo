extends CanvasLayer

func _ready():
	Input.action_release("move_down")
	Input.action_release("move_up")
	Input.action_release("move_left")
	Input.action_release("move_right")

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



var t = false
func _on_Menu_pressed():
	if t == false:
		get_node("Panel").show()
		t = !t
	else:
		get_node("Panel").hide()
		t = !t

func _on_Pause_pressed():
	get_tree().set_pause(true)
	print("Pause")

func _on_Unpause_pressed():
	get_tree().set_pause(false)
	print("Unpause")



var timer = 0.0
var timer2 = 0.0
var border = 0
func _on_RunButton_pressed():
	border += 20
	get_node("BarPanel/TextureProgress4").set_value(border)
	get_node("Timer 2").start()
	set_process(true)

var tt = false
func _on_Inventory_pressed():
	if tt == false:
		get_node("Inventory").show()
		tt = !tt
	else:
		get_node("Inventory").hide()
		tt = !tt

var ttt = false
func _on_Map_pressed():
	if tt == false:
		get_node("MapPanel").show()
		tt = !tt
	else:
		get_node("MapPanel").hide()
		tt = !tt



func _process(delta):
	timer += delta*20
	timer2 += delta*50
	get_node("BarPanel/TextureProgress3").set_value(timer)
	get_node("TimerValue").set_text(str(get_node("Timer 2").get_time_left()))
	
	for node in get_tree().get_nodes_in_group('persistent'):
		node.get_node("RadialBar").set_value(timer2)
	
	if timer >= border:
		set_process(false)
	
	if timer >= 100:
		timer = 0.0
		border -= 100
		get_node("BarPanel/TextureProgress3").set_value(timer)
		get_node("BarPanel/TextureProgress4").set_value(border)
	
	if timer2 >= 100:
		timer2 = 0.0
		for node in get_tree().get_nodes_in_group('persistent'):
			node.get_node("RadialBar").set_value(timer2)
		set_process(false)
	
	get_node("BarPanel/TextureProgress3/YBarValue1").set_text(str(round(timer)) + "/" + str(border))



func _on_Resume_pressed():
	get_node("Panel").hide()
	t = false

func _on_Options_pressed():
	get_node("Panel 2").show()

func _on_Exit_to_main_menu_pressed():
	print("To main menu")
	Transition.fade_to("res://scenes/MainMenu.tscn")

func _on_Exit_pressed():
	get_tree().quit()

func _on_OK_pressed():
	get_node("Panel 2").hide()



func _on_Save_pressed():
	global.savegame()

func _on_Load_pressed():
	global.loadgame()