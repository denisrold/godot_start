extends CanvasLayer
const TILE_BUSH = preload("res://kenney_scribble-platformer/PNG/Default/tile_bush.png")
const TILE_HEART = preload("res://kenney_scribble-platformer/PNG/Default/tile_heart.png")

func _ready() -> void:
	pass
func _on_game_controller_player_health_updated(new_player_health: Variant) -> void:
	$HBoxContainer/vida3.texture = TILE_HEART if new_player_health >= 1 else null
	$HBoxContainer/vida2.texture = TILE_HEART if new_player_health >= 2 else null
	$HBoxContainer/vida.texture = TILE_HEART if new_player_health >= 3 else null
