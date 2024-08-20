extends CharacterBody2D

var vida : int
@export var experiencia : PackedScene
@export var moneda : PackedScene
var daño = 100
var SPEED = 20.0
var player = null

signal muerto
func _ready():
	randomize()
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
		objeto.free()
	elif objeto.is_in_group("colision"):
		
		objeto.impacto()
	elif objeto.is_in_group("proyectilArea"):
		print("llegadaño")
		if objeto.dañar:
			vida -= objeto.daño
			
	elif objeto.is_in_group("antiVirus"):
		vida = 0
	
	
	if vida <= 0:
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
	var rand = randi_range(0,1)
	if rand :
		var gema = experiencia.instantiate()
		gema.position = self.position
		get_tree().call_group("mundo", "add_child",gema)
	else:
		var coin = moneda.instantiate()
		coin.position = self.position
		get_tree().call_group("mundo", "add_child",coin)
	emit_signal("muerto")
	queue_free()

