extends Node

enum paths {
	PATH_NONE,
	PATH_FIRE,
	PATH_WATER,
	PATH_AIR
}

const path_scripts = {
	paths.PATH_NONE: "res://Scripts/Player.gd",
	paths.PATH_FIRE: "res://Scripts/FirePlayer.gd",
	paths.PATH_WATER: "res://Scripts/WaterPlayer.gd",
	paths.PATH_AIR: "res://Scripts/AirPlayer.gd"
}

var player_path: int = paths.PATH_NONE

const p = preload("res://Scenes/Player.tscn")

func _ready():
	get_tree().set_auto_accept_quit(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	load_game()

const file_loc: String = "user://game_save.json"

func save_game() -> void:
	var save_file = File.new()
	save_file.open(file_loc, File.WRITE)
	save_file.store_line(to_json({
		"path": player_path
	}))
	save_file.close()

func load_game() -> void:
	var save_file = File.new()

	if not save_file.file_exists(file_loc):
		return

	save_file.open(file_loc, File.READ)
	var contents: String = save_file.get_as_text()
	save_file.close()

	var save_data = parse_json(contents)
	player_path = int(save_data["path"])

func _notification(what: int):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		save_game()
		get_tree().quit()
	if what == MainLoop.NOTIFICATION_WM_FOCUS_IN:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
