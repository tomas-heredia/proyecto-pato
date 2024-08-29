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
	Guardado.save_game()


func _on_salir_button_up():
	get_tree().quit()


func _on_reiniciar_button_up():
	emit_signal("reiniciar")
	get_tree().reload_current_scene()
	
func muerto(valor):
	$TextureRect/Label.text = "Has sido debugueado"
	Oleadas(valor)

func ganar(valor):
	$TextureRect/Label.text ="Los debugueaste"
	$TextureRect.texture = preload("res://.godot/imported/Sprite-MenuGanador.png-2b650ce13ca2f40db07dda5cdcebc967.ctex")
	Oleadas(valor)

func Oleadas(valor):
	$TextureRect/Oleadas.text = "Oleadas: "+ str(valor)
