extends Node2D
@export var bala : PackedScene
@export var velocidad_disparo: int
@export var daño: int
var velocidad_disparo_aux = velocidad_disparo
# Called when the node enters the scene tree for the first time.
func _ready():
	
	velocidad_disparo = 32 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (velocidad_disparo_aux != velocidad_disparo):
		velocidad_disparo_aux = velocidad_disparo
		$TiempoDisparo.wait_time= velocidad_disparo/32


func disparar():
	
	var disparo = bala.instantiate()
	disparo.velocidad_padre = get_parent().velocity
	disparo.rotation = self.rotation
	disparo.global_position = $Shoot/Direction.global_position
	disparo.direccion = $Shoot/Direction.get_global_position()-$Shoot.get_global_position()
	get_tree().call_group("mundo", "add_child",disparo)
	


func _on_tiempo_disparo_timeout():
	disparar()
