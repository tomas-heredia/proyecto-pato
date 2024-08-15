extends CharacterBody2D


const SPEED = 200.0


func _physics_process(delta):
	
	move_and_slide()


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
