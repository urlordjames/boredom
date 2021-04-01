extends KinematicBody

class_name Player

export var default_friction: float = 0.8
export var default_speed: float = 150
const sensitivity: float = 0.15
export var gravity: float = 0.5

onready var head: Spatial = $Head
onready var camera: Camera = $Head/Camera

onready var head_basis: Basis = head.get_global_transform().basis

export var default_coyote_time: float = 0.1
var coyote_time: float = 0

export var default_jump_strength: float = 15

export var default_move_cooldown: float = 0.5
var move_cooldown: float = 0

var velocity: Vector3 = Vector3()

func _ready():
	var desired_path: Script = load(Global.path_scripts[Global.player_path])
	if self.get_script() != desired_path:
		call_deferred("load_new_path", desired_path)

func load_new_path(path: Script) -> void:
	var inst: Player = Global.p.instance()
	inst.set_script(path)
	get_tree().get_root().add_child(inst)
	inst.translation = translation
	inst.head.rotation = head.rotation
	inst.camera.rotation = camera.rotation
	inst.velocity = velocity
	inst.camera.fov = camera.fov
	self.queue_free()

func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		head.rotate_y(-deg2rad(event.relative.x * sensitivity))

		var x_delta: float = event.relative.y * sensitivity

		if abs(camera.rotation_degrees.x - x_delta) <= 90:
			camera.rotate_x(-deg2rad(x_delta))

	if event is InputEventKey:
		if event.scancode == KEY_ESCAPE:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if coyote_time > 0 and event.is_action_pressed("jump"):
		jump()

	if move_cooldown <= 0 and event.is_action_pressed("movement"):
		movement()

func _physics_process(delta: float):
	head_basis = head.get_global_transform().basis
	
	var direction: Vector3 = Vector3()

	direction -= head_basis.z * Input.get_action_strength("move_forwards")
	direction += head_basis.z * Input.get_action_strength("move_backwards")
	direction -= head_basis.x * Input.get_action_strength("move_left")
	direction += head_basis.x * Input.get_action_strength("move_right")

	velocity.y -= gravity

	var friction: float = default_friction
	var speed: float = default_speed

	if not is_on_floor():
		friction = .95
		speed = 50
		coyote_time -= delta

	move_cooldown -= delta

	velocity += direction.normalized() * delta * speed

	velocity.x *= friction * delta * 60
	velocity.z *= friction * delta * 60

	camera.fov = 80 + (sqrt(pow(velocity.x, 2) + pow(velocity.z, 2)) / 10)

	velocity = move_and_slide(velocity, Vector3.UP)

	if is_on_floor():
		coyote_time = default_coyote_time

	if translation.y < -50:
		print_debug("sorry about that")
		self.queue_free()
		get_tree().reload_current_scene()

func jump() -> void:
	coyote_time = 0
	velocity.y = default_jump_strength

func movement() -> void:
	pass
