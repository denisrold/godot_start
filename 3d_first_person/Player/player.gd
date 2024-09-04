extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
#stats
var saludAhora : int = 10
var saludMax : int = 10
var ammo : int = 15
var score : int = 0

var minLookAngle : float = -90
var maxLookAngle : float = 90
var cameraSens : float = 7
#camera
var mouseDelta : Vector2 = Vector2()
@onready var camera = get_node("CameraOrbit")
	 # Tiempo delta entre frames
	
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouseDelta = event.relative
		

func _process(delta: float) -> void:
	# Convertir sensibilidad y delta a radianes
	var sens_x = deg_to_rad(mouseDelta.y * cameraSens * delta)
	var sens_y = deg_to_rad(mouseDelta.x * cameraSens*10 * delta)

	# Rotar eje X (mirar arriba/abajo)
	var new_x_rotation = camera.rotation.x + sens_x
	new_x_rotation = clamp(new_x_rotation, deg_to_rad(minLookAngle), deg_to_rad(maxLookAngle))
	camera.rotation.x = new_x_rotation

	# Rotar eje Y (mirar izquierda/derecha)
	camera.rotation.y -= sens_y

	# Reiniciar el mouse_delta
	mouseDelta = Vector2()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
