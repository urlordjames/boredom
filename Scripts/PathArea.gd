extends Area

export(Global.paths) var path = Global.paths.PATH_FIRE
var path_script: Script = load(Global.path_scripts[path])

func _on_body_entered(body: Node):
	if not body is Player:
		return

	var p: Player = body
	if Global.player_path != path:
		Global.player_path = path
		p.load_new_path(path_script)
