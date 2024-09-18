extends Enemigo

class_name Azul

func _ready():
	randomize()
	
	vida = Globales.vidaAzul
	daño = Globales.DañoAzul
