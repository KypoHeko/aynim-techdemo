extends CanvasLayer

#подгружаем сцену с персонажем для передвижения по кнопкам
onready var player = get_tree().get_nodes_in_group('persistent')[0].get_node("AnimatedSprite")
#позиция камеры
var camera_pos = Vector2(0, 0)
#переменная для активной кнопки
var NPCname = ""

func _ready():
	global.input_release()
	set_process(true)

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
	get_tree().get_nodes_in_group('inv')[0].loaditems()
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


#реализация таймеров (переделать)
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
var id_quest = ""
var count = 0
var text

#просто разговариваем с NPC
func just_talk(string):
	if string != "":
		id_quest = string
		text = global.loadtext(id_quest)
	
	if count == 0:
		get_node("Action/Talk").play()
	
	get_node("CloudText").show()
	get_node("CloudText/Text").set_text(text[count])
	count += 1
	if (count == text.size()):
		count = 0
		close_dialog("", "")

#болтаем с NPC выдающими квест
func quest_talk(string):
	get_node("CloudText/ctNextq").show()
	id_quest = string
	#проверяем на каком моменте наш квест
	#он выполняется?
	if id_quest in global.player_quests:
		text = global.loadtext(id_quest + "p")
		global.quest_completed()
	#он завершен?
	elif id_quest in global.player_c_quests:
		text = global.loadtext(id_quest + "e")
	#или мы его только принимаем?
	else:
		text = global.loadtext(id_quest + "s")
		if (count == (text.size() - 2)):
			get_node("CloudText/ctOK").show()
			get_node("CloudText/ctNo").show()
			get_node("CloudText/ctNext").hide()
			get_node("CloudText/ctNextq").hide()
	
	just_talk("")

#закрыть облако при нажатии ОК
func _on_ctOK_pressed():
	close_dialog("OK", id_quest)

#закрыть облако при нажатии No
func _on_ctNo_pressed():
	close_dialog("", "")

#следующая фраза в диалоге
func _on_ctNext_pressed():
	just_talk("")

func _on_ctNextq_pressed():
	quest_talk(id_quest)

#скрывание облака после завершения диалога
func close_dialog(sol, id_quest):
	get_node("CloudText").hide()
	get_node("CloudText/ctOK").hide()
	get_node("CloudText/ctNo").hide()
	get_node("CloudText/ctNext").show()
	get_node("CloudText/ctNextq").hide()
	get_tree().get_nodes_in_group("hud")[0].camera_pos = Vector2(0, 0)
	t4 != t4
	count = 0
	
	#добавляем квест при соглашении
	if sol == "OK":
		global.player_quests.append(id_quest)
		get_tree().get_nodes_in_group('inv')[0].add_quest(global.loadquest(id_quest))

func trade(string):
	get_node("bazaar").renew_items()
	get_node("bazaar").show()
	
	if get_parent().get_name() == "FirstScene":
		global.firstscene[int(string.substr(8, 1))] = 1
	if get_parent().get_name() == "SecondScene":
		global.secondscene[int(string.substr(8, 1))] = 1
	if get_parent().get_name() == "ThirdScene":
		global.thirdscene[int(string.substr(8, 1))] = 1



#дать опыт
func _on_GiveEXP_pressed():
	global.add_stat(1000)

#передвижение камеры
func _on_Camera1_pressed():
	camera_pos = Vector2(800, 0)

func _on_Camera2_pressed():
	camera_pos = Vector2(0, 0)

func _on_Camera3_pressed():
	camera_pos = Vector2(0, 800)

func _on_Drop_pressed():
	var player = get_tree().get_nodes_in_group('persistent')[0]
	var add_drop = preload("res://scenes/Drop.tscn")
	var drop = add_drop.instance()
	drop.set_pos(player.get_pos())
	get_parent().add_child(drop)

func _on_LootInArea_pressed():
	print(global.dictforloot.values())



func _on_Action_pressed():
	var temp = get_node("Action/Label").get_text()
	if temp == "Talk!":
		just_talk(NPCname)
	if temp == "Quest!":
		quest_talk(NPCname)
	if temp == "Trade!":
		trade(NPCname)
		get_node("Action/Trade").play()
	if temp == "Loot!":
		get_node("Loot").show()
		get_node("Loot").renew_items()


func _on_Action_button_down():
	var temp = get_node("Action/Label").get_text()
	if temp == "Attack!":
		Input.action_press("ui_select")

func _on_Action_button_up():
	Input.action_release("ui_select")