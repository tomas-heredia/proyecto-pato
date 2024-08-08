extends CharacterBody2D

var SPEED = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	$Colision.connect("Impacto",impacto)
	$Area/CollisionShape2D.disabled = true
	$Area.visible = false 
	$AnimationPlayer.play("rotation")

func impacto():
	$MateSprite.hide()
	$Area.show()
	$Area.visible = true 
	velocity = Vector2(0,0)
	$AreaTimer.start()
	$DañoTimer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide()


func _on_timer_timeout():
	queue_free()


func _on_daño_timer_timeout():
	print("llega")
	$Area/CollisionShape2D.disabled = false
	
	$Area/CollisionShape2D.disabled = true


