extends Node2D

@export var player_life = 3
signal player_health_updated(new_player_health)

func game_over():
	print("Has Perdido")

func game_victory():
	print("Has Ganado")


func _on_personaje_player_hit() -> void:
	print('recibo señal de que el jugador ha recibido daño')
	if player_life > 0:
		player_life = player_life -1
		player_health_updated.emit(player_life)
	else:
		game_over()


func _on_area_2d_body_entered(body: Node2D) -> void:
	game_victory()
