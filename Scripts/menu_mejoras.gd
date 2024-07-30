extends CanvasLayer

signal aumentarDaño
signal aumentarVida
signal aumentarVelocidad

# Called when the node enters the scene tree for the first time.
func _ready():
	#hide()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func pausar():
	get_tree().paused = not get_tree().paused
	
func _on_mas_daño_button_up():
	emit_signal("aumentarDaño")


func _on_mas_velocidad_button_up():
	emit_signal("aumentarVelocidad")


func _on_mas_vida_button_up():
	emit_signal("aumentarVida")
	

