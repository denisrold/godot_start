extends CharacterBody3D

var curHp: int = 10
var maxHp : int = 10
var damage :int = 1
var attackDist : float = 1.5
var attackRate : float = 1.0

#var velocity = Vector3()
const SPEED = 2.5
const JUMP_VELOCITY = 4.5

@onready var timer = get_node("Timer")
@onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready() -> void:
	timer.wait_time = attackRate
	timer.start()

func _physics_process(delta: float) -> void:
	var dist = position.distance_to(player.position)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if dist > attackDist:
		var dir = (player.position - position).normalized()
		velocity.x = dir.x
		velocity.y = 0
		velocity.z = dir.z
	move_and_slide()


func _on_timer_timeout() -> void:
	if position.distance_to(player.position) <= attackDist:
		player.take_damage(damage)

func take_damage(damage):
	curHp -= damage
	print("Enemy health", curHp)
	if curHp <= 0:
		die()

func die():
	queue_free()
