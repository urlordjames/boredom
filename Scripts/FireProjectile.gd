extends RayCast

func shoot():
	force_raycast_update()
	if is_colliding():
		var target = get_collider()
		print_debug(target.name)
	queue_free()
