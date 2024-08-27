extends Camera2D

@export var object_to_follow:Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if object_to_follow:
		position = object_to_follow.position

func _physics_process(delta: float) -> void:
	pass
