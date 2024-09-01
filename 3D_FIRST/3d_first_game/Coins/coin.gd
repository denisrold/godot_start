extends Area3D

@export var goldToGive = 1
var rotate_speed : float = 5.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(rotate_speed*delta);


func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		body.give_gold(goldToGive)
		print(body.gold);
		queue_free()
