extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	$CanvasLayer/TextureRect/Monedas.text = "Monedas: "+ str(Guardado.game_data.monedas)
	$CanvasLayer/TextureRect/Vida.text = "Vida: "+ str(5*Guardado.game_data.mejoras.vida)
	$CanvasLayer/TextureRect/Daño.text = "Daño: "+ str(5*Guardado.game_data.mejoras.daño)
	$CanvasLayer/TextureRect/Velocidad.text = "Velocidad: "+ str(5*Guardado.game_data.mejoras.velocidad)

func _on_vida_pressed():
	if Guardado.game_data.monedas >= 5*Guardado.game_data.mejoras.vida:
		Guardado.game_data.monedas -=5*Guardado.game_data.mejoras.vida
		Guardado.game_data.vida += 100
		Guardado.game_data.mejoras.vida +=1


func _on_daño_pressed():
	if Guardado.game_data.monedas >= 5*Guardado.game_data.mejoras.daño:
		Guardado.game_data.monedas -=5*Guardado.game_data.mejoras.daño
		Guardado.game_data.daño += 100
		Guardado.game_data.mejoras.daño +=1




func _on_velocidad_pressed():
	if Guardado.game_data.monedas >= 5*Guardado.game_data.mejoras.velocidad:
		Guardado.game_data.monedas -=5*Guardado.game_data.mejoras.velocidad
		Guardado.game_data.velocidad += 100
		Guardado.game_data.mejoras.velocidad +=1



func _on_regresar_pressed():
	Guardado.save_game()
	get_tree().change_scene_to_file("res://Scenes/Menu_inicio.tscn")
