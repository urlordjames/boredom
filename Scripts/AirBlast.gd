extends Area

func _physics_process(_delta: float):
	var victims = get_overlapping_areas()
	
	for victim in victims:
		var enemy: Enemy = victim.get_parent()
		enemy.damage(50)
	
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	queue_free()
