extends Enemigo
class_name Zombie

func _ready():
	randomize()
	vida = Globales.VidaZombie
	daño = Globales.DañoZombie
	SPEED = Globales.VelocidadZombie

func _physics_process(delta):
	frameCount = !frameCount
	if frameCount:
		follow()


func _on_seguimineto_body_entered(body):
	if body.is_in_group("Player"):
		player = get_tree().get_nodes_in_group("Player")[0]

func follow():
	if player != null && vivo:
		velocity = position.direction_to(player.position) * SPEED
		animaciones()
		move_and_slide()

