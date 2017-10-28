extends KinematicBody2D

const MOTION_SPEED = 300

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var motion = Vector2()
	motion = motion.normalized()*MOTION_SPEED*delta