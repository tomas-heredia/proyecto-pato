extends CanvasLayer

signal reiniciar
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func pausar():
	get_tree().paused = not get_tree().paused
	


func _on_salir_button_up():
	get_tree().quit()


func _on_reiniciar_button_up():
	emit_signal("reiniciar")
	get_tree().reload_current_scene()
	
func muerto(valor):
	$TextureRect/Label.text = "Te han debugueado"
	Oleadas(valor)

func ganar(valor):
	$TextureRect/Label.text ="Los debugueaste"
	Oleadas(valor)

func Oleadas(valor):
	$TextureRect/Oleadas.text = "Oleadas: "+ str(valor)
