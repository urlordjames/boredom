extends Area

# workaround for godot export enum bug
enum paths {
	PATH_NONE,
	PATH_FIRE,
	PATH_WATER,
	PATH_AIR
}

export(paths) var path = paths.PATH_FIRE
var path_script: Script = load(Global.path_scripts[path])

func _on_body_entered(body: Node):
	if not body is Player:
		return

	var p: Player = body
	if Global.player_path != path:
		Global.player_path = path
		p.load_new_path(path_script)
