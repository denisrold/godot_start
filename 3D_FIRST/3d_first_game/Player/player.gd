extends CharacterBody3D
const SPEED = 5.0
const JUMP_VELOCITY = 5.5

var curHp: int = 10
var maxHp : int = 10
var damage :int = 3

var gold : int = 0 
var attackRate : float = .9
var lastAttackTiem : int = 0

var moveSpeed : float = 5.0
var jumpForce : float = 10.0
var gratvity : float = 15.0

var vel = Vector3()

@onready var camera = $Pivote
@onready var attackCast = $AttackRayCast
@onready var UI = $Interfaz/UI

func _ready() -> void:
	UI.Update_Gold_text(gold)
	UI.update_health_bar(curHp,maxHp)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _process(delta:float) -> void:
	if Input.is_action_pressed("Attack"):
		try_attack()

func try_attack():
	if Time.get_ticks_msec() - lastAttackTiem < attackRate * 1000:
		return
		
	lastAttackTiem = Time.get_ticks_msec()
	
	$WeaponHolder/Sword/AnimationPlayer.stop()
	$WeaponHolder/SwordAnimator.play("Attack")
	if attackCast.is_colliding():
		if attackCast.get_collider().has_method("take_damage"):
			attackCast.get_collider().take_damage(damage)

func give_gold(goldToGive:int):
	gold+=goldToGive
	UI.Update_Gold_text(gold)

func take_damage(damageRecibed):
	curHp -= damageRecibed
	UI.update_health_bar(curHp,maxHp)
	if curHp <= 0:
		die()

func die():
	get_tree().reload_current_scene()
