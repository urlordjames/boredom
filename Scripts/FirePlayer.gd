extends "res://Scripts/Player.gd"

class_name FirePath

const particle = preload("res://Scenes/FireDashParticle.tscn")

func _init():
	default_speed = 165

func movement():
	var inst: Node = particle.instance()
	get_tree().get_root().add_child(inst)
	inst.rotation = head.rotation
	inst.global_transform = head.global_transform
	move_cooldown = default_move_cooldown
	velocity -= head_basis.z * 50
	velocity.y = 0
