extends CharacterBody2D

var vida : int
var SPEED = 300.0

func _ready():
	vida = 300

func _physics_process(delta):
	
	move_and_slide()


func _on_seguimineto_body_entered(body):
	if body.is_on_group("Player"):
		velocity
	pass
