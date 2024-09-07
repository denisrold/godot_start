extends Node3D

enum Tipo_De_Objeto { 
	Ammo, 
	Health 
	}

@export  var objeto : Tipo_De_Objeto = Tipo_De_Objeto.Health

@export var ammount : int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play('ready')
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		pickup(body)
		queue_free()

func  pickup(body):
	if objeto == Tipo_De_Objeto.Ammo:
		body.add_ammo(ammount)
		print("entre en ammo")
	if objeto == Tipo_De_Objeto.Health:
		print("entre en vida")
		body.agregar_vida(ammount);
