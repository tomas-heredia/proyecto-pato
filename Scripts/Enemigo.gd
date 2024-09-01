extends CharacterBody2D

var vivo :bool = true
var vida : int
@export var experiencia : PackedScene
@export var moneda : PackedScene
@export var life : PackedScene
var daño : int
var SPEED = 20.0
var player = null
var frameCount : bool = false
signal muerto
func _ready():
	randomize()
	vida = Globales.VidaZombie
	daño = Globales.DañoZombie
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


func _on_area_2d_area_entered(objeto):
	
	if objeto.is_in_group("Balas"):
		$AnimationPlayer.play("dañado")
		vida = vida - objeto.get_parent().daño
		objeto.free()
	elif objeto.is_in_group("colision"):
		
		objeto.impacto()
	elif objeto.is_in_group("proyectilArea"):
		$AnimationPlayer.play("dañado")
		if objeto.dañar:
			vida -= objeto.daño
			
	
	
	
	if vida <= 0:
		vivo = false
		muerte()
	
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
				

func muerte():
	
	$AnimationPlayer.play("muerte")
	
	


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "muerte":
		var rand = randi_range(0,3)
		if rand == 0:
			var gema = experiencia.instantiate()
			gema.position = self.position
			get_tree().call_group("mundo", "add_child",gema)
		elif rand == 1:
			var coin = moneda.instantiate()
			coin.position = self.position
			get_tree().call_group("mundo", "add_child",coin)
		elif rand == 3:
			var hp = life.instantiate()
			hp.position = self.position
			get_tree().call_group("mundo", "add_child",hp)
		emit_signal("muerto")
		queue_free()

