extends Enemigo
class_name bug

func _ready():
	randomize()
	SPEED = Globales.VelocidadBug
	vida = Globales.VidaBug
	daño = Globales.DañoBug
	follow()
	
func _physics_process(delta):
	move_and_slide()

func follow():
	player = get_tree().get_nodes_in_group("Player")[0]
	if player != null && vivo:
		
		velocity = global_position.direction_to(player.global_position) * SPEED
		animaciones()
		


