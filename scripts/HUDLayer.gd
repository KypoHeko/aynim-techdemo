extends CanvasLayer

#подгружаем сцену с персонажем для передвижения по кнопкам
onready var player = get_tree().get_nodes_in_group('persistent')[0].get_node("AnimatedSprite")

func _ready():
	global.input_release()

#передвижение, анимация и остановка (вверх)
func _on_ButtonUp_button_down():
	Input.action_press("move_up")
func _on_ButtonUp_button_up():
	Input.action_release("move_up")
	player.play("STAY")
	player.set_frame(4)

#передвижение, анимация и остановка (вправо)
func _on_ButtonRight_button_down():
	Input.action_press("move_right")
func _on_ButtonRight_button_up():
	Input.action_release("move_right")
	player.play("STAY")
	player.set_frame(2)

#передвижение, анимация и остановка (вниз)
func _on_ButtonDown_button_down():
	Input.action_press("move_down")
func _on_ButtonDown_button_up():
	Input.action_release("move_down")
	player.play("STAY")
	player.set_frame(0)

#передвижение, анимация и остановка (влево)
func _on_ButtonLeft_button_down():
	Input.action_press("move_left")
func _on_ButtonLeft_button_up():
	Input.action_release("move_left")
	player.play("STAY")
	player.set_frame(2)

#анимация атаки
func _on_Attack_button_down():
	Input.action_press("ui_select")
func _on_Attack_button_up():
	Input.action_release("ui_select")



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

var t3 = false
func _on_Map_pressed():
	if t3 == false:
		get_node("MapPanel").show()
		t3 = !t3
	else:
		get_node("MapPanel").hide()
		t3 = !t3



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


var t4 = false
func _on_Text_pressed():
	if t4 == false:
		get_node("CloudText").show()
		t4 = !t4
	else:
		get_node("CloudText").hide()
		t4 = !t4


var text
var quest = "firstquest"
var count = 0
func _on_ChangeText_pressed():
	quest = "Text1"
	text = global.loadtext("text1")
	get_node("CloudText/Text").set_text(text[count])
	count += 1
	if (count == (text.size() - 1)):
		get_node("CloudText/ctOK").show()
		get_node("CloudText/ctNo").show()
	if (count > (text.size() - 1)):
		global.dialog("", "")

func _on_ChangeText1_pressed():
	quest = "Text2"
	text = global.loadtext("text2")
	get_node("CloudText/Text").set_text(text[count])
	count += 1
	if (count == (text.size() - 1)):
		get_node("CloudText/ctOK").show()
		get_node("CloudText/ctNo").show()
	if (count > (text.size() - 1)):
		global.dialog("", "")

#закрыть облако при нажатии ОК
func _on_ctOK_pressed():
	print("You say OK!")
	global.dialog("OK", quest)

#закрыть облако при нажатии No
func _on_ctNo_pressed():
	print("You say no. :(")
	global.dialog("NO", "")

#дать опыт
func _on_GiveEXP_pressed():
	global.add_stat(1000)
