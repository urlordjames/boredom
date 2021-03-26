extends "res://Scripts/Player.gd"

class_name WaterPath

func _ready():
	default_speed = 220

func jump():
	coyote_time = 0
	velocity.y = 15
