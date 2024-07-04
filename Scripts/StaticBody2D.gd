extends CharacterBody2D

var direccion :Vector2
var velocidad_padre:Vector2
@export var SPEED:int
var daño : int
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity += direccion*SPEED
	velocity = velocity+velocidad_padre
	move_and_slide()

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
func set_velocidad_padre(velocidad):
	velocidad_padre = velocidad
