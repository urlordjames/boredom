extends RayCast

func shoot():
	force_raycast_update()
	if is_colliding():
		var enemy: Enemy = get_collider().get_parent()
		enemy.damage(50)
	queue_free()
