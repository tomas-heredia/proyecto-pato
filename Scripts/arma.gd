extends Node2D
@export var bala : PackedScene
@export var velocidad_disparo: int
var daño
var velocidad_disparo_aux = velocidad_disparo

# Called when the node enters the scene tree for the first time.
func _ready():

	daño = Guardado.game_data["daño"] * Guardado.game_data.mejoras.velocidad
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
	
	
	disparo.global_position = $Sprite2D/Shoot/Direction.global_position
	disparo.direccion = $Sprite2D/Shoot/Direction.get_global_position()-$Sprite2D/Shoot.get_global_position()
	disparo.daño = daño
	get_tree().call_group("mundo", "add_child",disparo)
	$ShootSound.play()


func _on_tiempo_disparo_timeout():
	disparar()

