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
@onready var pivote = get_node("CameraOrbit/Camera3D/Shotgun/Node3D")
#preload cuando se cargue el jugador en memoria cargara la escena de la bala/
@onready var bulletScene = preload("res://bullets/bullet.tscn")
	 # Tiempo delta entre frames
	
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouseDelta = event.relative
		

func _process(delta: float) -> void:
	# Convertir sensibilidad y delta a radianes
	var sens_x = -deg_to_rad(mouseDelta.y * cameraSens * delta)
	var sens_y = deg_to_rad(mouseDelta.x * cameraSens*10 * delta)

	# Rotar eje X (mirar arriba/abajo)
	var new_x_rotation = camera.rotation.x + sens_x
	new_x_rotation = clamp(new_x_rotation, deg_to_rad(minLookAngle), deg_to_rad(maxLookAngle))
	camera.rotation.x = new_x_rotation

	# Rotar eje Y (mirar izquierda/derecha)
	camera.rotation.y -= sens_y

	# Reiniciar el mouse_delta
	mouseDelta = Vector2()
	
	if Input.is_action_just_pressed("shoot"):
		disparar()

func disparar():
	var bullet = bulletScene.instantiate()
	get_tree().get_root().add_child(bullet)
	#Igualo la global transform de mi bala a la del pivote
	bullet.global_transform = pivote.global_transform
	#desigualo la escala que tambien se iguao de mi transform
	bullet.scale = Vector3.ONE
	ammo -= 1

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
	
	# Usar la rotación de la cámara para determinar la dirección del movimiento
	var camera_basis = camera.global_transform.basis
	#normalizar nuestro vector para que no se vaya demasiado en diagonal ni em direcciones.
	var direction = (camera_basis.x * input_dir.x + camera_basis.z * input_dir.y).normalized()
	
	if direction != Vector3.ZERO:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
