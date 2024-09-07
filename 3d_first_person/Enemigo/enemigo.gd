extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var salud = 5
var velMov = 1
var damage = 1
var attackRate = 1
var attackDist = 2

var puntosQueDa = 10

# componentes
@onready var player : Node = get_node("/root/World/Player")
@onready var timer : Timer = get_node("Timer")

func _ready() -> void:
	timer.set_wait_time(attackRate)
	 

func _physics_process(delta: float) -> void:
	var dir = (player.global_position - global_position).normalized()
	dir.y = 0  # Aseguramos que el enemigo no se mueva en el eje Y.
	var speed: float = 100
	velocity = dir * speed * delta
	move_and_slide()

func take_damage(damaged):
	salud -= damaged
	
	if salud <= 0:
		morirse()
		
func morirse():
	player.add_score(puntosQueDa)
	queue_free()

func atacar():
	player.take_damage(damage)


func _on_timer_timeout() -> void:
	var distance =  position.distance_to(player.position)
	if distance <= attackDist:
		atacar()
	pass # Replace with function body.
