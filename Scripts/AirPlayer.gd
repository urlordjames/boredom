extends "res://Scripts/Player.gd"

class_name AirPath

func _init():
	default_speed = 165
	default_coyote_time = INF
	
func djump():
	move_cooldown = default_move_cooldown
	if is_on_floor() == false:
		jump()
