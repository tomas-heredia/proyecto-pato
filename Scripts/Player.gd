extends CharacterBody2D


@export var SPEED = 300.0
var directionX
var directionY
var vectorRotacion:Vector2
@export var vidaTotal = 300
var vida
var experiencia = 0
var siguienteNivel = 100
var nivel = 1
signal pararZombies
signal subirNivel

func _ready():
	vida = vidaTotal

func _physics_process(delta):
	moverMarco()
	directionX = Input.get_axis("Izquierda", "Derecha")
	
	if directionX:
		
		
		velocity.x = directionX * SPEED
		
	else:
		
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	directionY = Input.get_axis("Arriba", "Abajo")
	if directionY:
		velocity.y = directionY * SPEED
		
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	velocity = velocity.normalized()*SPEED
	vectorRotacion = velocity
	var tween = create_tween()
	var dir = lerp_angle($Arma.rotation, vectorRotacion.angle(), 1)
	tween.tween_property($Arma,"rotation",dir,0.3)
	move_and_slide()
	
	animaciones()
	
func animaciones():
	if velocity == Vector2.ZERO:
		$AnimatedSprite2D.play("Idle")
		$Arma/Sprite2D.flip_v = false
	else:
		$AnimatedSprite2D.play("Walk")
		
		if velocity.x >0 :
			$AnimatedSprite2D.flip_h = false
			$Arma/Sprite2D.flip_v = false
		else:
			if velocity.x <0 :
				$AnimatedSprite2D.flip_h = true
				$Arma/Sprite2D.flip_v = true

func moverMarco():
	$Path2D.curve.set_point_position(0,position+Vector2(-300,-200))
	$Path2D.curve.set_point_position(1,position+Vector2(300,-200))
	$Path2D.curve.set_point_position(2,position+Vector2(300,200))
	$Path2D.curve.set_point_position(3,position+Vector2(-300,200))
	$Path2D.curve.set_point_position(4,position+Vector2(-300,-200))


func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemigos"):
		vida = vida - area.get_parent().daño
		if vida <= 0:
			hide()
			$Arma/TiempoDisparo.stop()
			emit_signal("pararZombies")
	else:
		if area.is_in_group("Exp"):
			experiencia = experiencia + 100
			area.queue_free()
			if experiencia >= siguienteNivel:
				experiencia -= siguienteNivel
				siguienteNivel += 500
				nivel += 1
				emit_signal("subirNivel")

func aumentar_vida(valor):
	vidaTotal +=  valor
	vida = vidaTotal

func aumentar_daño(valor):
	$Arma.daño += valor

func aumentar_velocidad(valor):
	SPEED += valor
