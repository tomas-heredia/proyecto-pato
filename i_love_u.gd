extends Enemigo


func _ready():
	randomize()
	player = get_tree().get_nodes_in_group("Player")[0]
	SPEED = player.SPEED +20
	vida = Globales.vidaILoveU
	daño = Globales.DañoILoveU


