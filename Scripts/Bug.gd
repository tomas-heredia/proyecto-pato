extends CharacterBody2D
var vivo :bool = true
var vida : int
@export var experiencia : PackedScene
@export var moneda : PackedScene
@export var life : PackedScene
var daño : int
var SPEED = 200.0
var player = null
var frameCount : bool = false
signal muerto
func _ready():
	randomize()
	vida = Globales.VidaBug
	daño = Globales.DañoBug
	follow()
	
func _process(delta):
	move_and_slide()

func follow():
	player = get_tree().get_nodes_in_group("Player")[0]
	if player != null && vivo:
		
		velocity = global_position.direction_to(player.global_position) * SPEED
		animaciones()
		


func _on_area_2d_area_entered(objeto):
	if vivo:
		if objeto.is_in_group("Balas"):
			$AnimationPlayer.play("dañado")
			vida = vida - objeto.get_parent().daño
			objeto.free()
		elif objeto.is_in_group("colision"):
			
			objeto.impacto()
		elif objeto.is_in_group("proyectilArea"):
			$AnimationPlayer.play("dañado")
			if objeto.dañar:
				velocity = Vector2(0,0)
				vida -= objeto.daño
				

		if vida <= 0 :
			vivo = false
			$AnimationPlayer.play("muerte")
	
func animaciones():
	if velocity == Vector2.ZERO:
		$AnimatedSprite2D.play("Idle")
		
	else:
		$AnimatedSprite2D.play("Walk")
		


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
		else:
			var hp = life.instantiate()
			hp.position = self.position
			get_tree().call_group("mundo", "add_child",hp)
		emit_signal("muerto")
		queue_free()


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
