class_name Personaje

extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -480.0
@onready var sprite_2d_2: Sprite2D = $Sprite2D2

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("saltar") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("izquierda", "derecha")
	if direction:
		velocity.x = direction * SPEED
	else:
	# Desacelera si no se está moviendo en ninguna dirección
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
