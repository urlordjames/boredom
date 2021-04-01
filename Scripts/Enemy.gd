extends KinematicBody

class_name Enemy

export var base_health: int = 100
var health = base_health

func damage(amount: int) -> bool:
	health -= amount
	if health <= 0:
		die()
		return true
	return false

func die() -> void:
	queue_free()

func restore() -> void:
	health = base_health
