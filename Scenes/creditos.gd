extends Control


# Called when the node enters the scene tree for the first time.
func _process(delta):
	
	$CanvasLayer/TextureRect/EnemigosTotales.text = "Enemigos eliminados: " + str(Guardado.game_data.enemigosMuertos)
	$CanvasLayer/TextureRect/MonedasTotales.text = "Monedas conseguidas: "+ str(Guardado.game_data.monedasTotales)
	$CanvasLayer/TextureRect/OleadaMaxima.text ="Maxima oleada alcanzada: "+ str(Guardado.game_data.oleadaMaxima)



func _on_regresar_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu_inicio.tscn")
