class_name barril
extends RigidBody2D
@export var demasiado_bajo = 750 
var damage_done = false
const UI_CIRCLE = preload("res://kenney_scribble-platformer/PNG/Retina/tile_coin.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.y > demasiado_bajo:
		queue_free();


func _on_body_entered(body: Node) -> void:
	if body is Personaje:
		if not damage_done:
			print('jugador herido')
			damage_done = true
			$Sprite2D.texture = UI_CIRCLE
			if body.has_method("damage_received"):
				body.damage_received()
