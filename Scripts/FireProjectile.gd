extends RayCast

const frames_visible: int = 15
const start_radius: float = 0.1
const end_radius: float = 0.0
const delta_radius: float = (start_radius - end_radius) / frames_visible

onready var mesh: MeshInstance = $LaserMesh
onready var cylinder: CylinderMesh = CylinderMesh.new()

func shoot():
	force_raycast_update()

	mesh.mesh = cylinder
	cylinder.top_radius = 0.1
	cylinder.bottom_radius = 0.1

	var dist: float = -cast_to.z

	if is_colliding():
		var enemy: Enemy = get_collider().get_parent()
		enemy.damage(50)
		dist = global_transform.origin.distance_to(get_collision_point())

	mesh.transform.origin.z = -dist / 2
	cylinder.height = dist

	# yield to ensure mesh gets drawn
	for i in range(0, frames_visible):
		yield(get_tree(), "idle_frame")
		cylinder.top_radius -= delta_radius
		cylinder.bottom_radius -= delta_radius

	queue_free()
