extends "res://Scripts/Player.gd"

class_name FirePath

func _init():
	default_speed = 165

const particle = preload("res://Scenes/FireDashParticle.tscn")

func movement():
	var inst = particle.instance()
	get_tree().get_root().add_child(inst)
	inst.global_transform = head.global_transform
	move_cooldown = default_move_cooldown
	velocity -= head_basis.z * 50
	velocity.y = 0

const projectile = preload("res://Scenes/FireProjectile.tscn")

func primary():
	var inst = projectile.instance()
	get_tree().get_root().add_child(inst)
	inst.global_transform = camera.global_transform
	inst.shoot()
