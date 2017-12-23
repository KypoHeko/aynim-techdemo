extends Node2D

onready var player = get_tree().get_nodes_in_group('persistent')[0]
onready var stick = get_node("Panel/Stick")

var val_x
var val_y
var new_x
var new_y
var hypotenuse
var motion = Vector2(0,0)

func _ready():
	set_process(true)

#передвижение
func _process(delta):
	if stick.get_pos() != Vector2(100,100):
		player.move(motion)

#создаем условие на клик мышкой по джойстику
func _on_Panel_input_event( ev ):
	val_x = get_local_mouse_pos().x
	val_y = get_local_mouse_pos().y
	hypotenuse = pow(val_x, 2) + pow(val_y, 2)
	
	var mouse_left = Input.is_action_pressed("mouse_left")
	
	#перемещаем стик
	if mouse_left:
		#ограничиваем расстояние стика
		if hypotenuse < 10000:
			stick.set_pos(Vector2(val_x + 100, val_y + 100))
			new_x = val_x
			new_y = val_y
		#искуссственное скольжение по окружности
		else:
			new_x = (val_x / sqrt(hypotenuse)) * 100
			new_y = (val_y / sqrt(hypotenuse)) * 100
			stick.set_pos(Vector2(new_x + 100, new_y + 100))
		#скорость передвижения персонажа
		motion = Vector2(new_x / 25, new_y / 25)
		print(new_x, " ", new_y)
	#возвращаем в центр
	else:
		stick.set_pos(Vector2(100, 100))