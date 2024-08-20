extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
		Guardado.load_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_iniciar_button_up():
	get_tree().change_scene_to_file("res://Scenes/mundo.tscn")


func _on_tienda_button_up():
	get_tree().change_scene_to_file("res://Scenes/tienda.tscn")


func _on_salir_pressed():
	get_tree().quit()
