extends CharacterBody2D

var vida : int
var SPEED = 30.0
var player = null
func _ready():
	vida = 300

func _physics_process(delta):
	
	follow()


func _on_seguimineto_body_entered(body):
	if body.is_in_group("Player"):
		player = get_tree().get_nodes_in_group("Player")[0]

func follow():
	if player != null:
		velocity = position.direction_to(player.position) * SPEED
		animaciones()
		move_and_slide()


func _on_area_2d_area_entered(objeto):
	if objeto.is_in_group("Balas"):
		
		vida = vida - objeto.get_parent().daño
	if vida <= 0:
		queue_free()

func animaciones():
	if velocity == Vector2.ZERO:
		$AnimatedSprite2D.play("Idle")
		
	else:
		$AnimatedSprite2D.play("Walk")
		
		if velocity.x >0 :
			$AnimatedSprite2D.flip_h = false
			
		else:
			if velocity.x <0 :
				$AnimatedSprite2D.flip_h = true
				



