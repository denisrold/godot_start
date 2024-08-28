class_name Boss
extends Node2D

const Escena_Barril = preload("res://Objetos_de_mapa/barril.tscn")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
	
func launch_barrel():
	var intancia_barril = Escena_Barril.instantiate()
	intancia_barril.position = $Body/Hand.position
	add_child(intancia_barril)
	animation_player.play("reposo");

func _on_timer_timeout() -> void:
	$AnimationPlayer.play("lanzar")
	$Timer.wait_time = randf_range(1,4)
