extends Node2D

const SCENE_FINISH_FILE = "res://map/scene_finish.tscn"

signal player_health_updated(new_player_health)
signal time_updated(time_left)
@export var player_life = 3
@export var time_seconds = 60


func game_over():
	get_tree().change_scene_to_file(SCENE_FINISH_FILE)

func game_victory():
	var scene_finish_instance = preload(SCENE_FINISH_FILE).instantiate()
	scene_finish_instance.set_title("Haas Ganado!")
	add_child(scene_finish_instance)


func _on_personaje_player_hit() -> void:
	if player_life > 1:
		player_life = player_life -1
		player_health_updated.emit(player_life)
	else:
		game_over()


func _on_area_2d_body_entered(body: Node2D) -> void:
	game_victory()


func _on_timer_timeout() -> void:
	if time_seconds > 0:
		time_seconds = time_seconds - 1
	if time_seconds <= 0:
		game_over()
	time_updated.emit(time_seconds)
