extends Node2D
@export var Zombie : PackedScene
@export var menuNivel : PackedScene
@export var Mate : PackedScene


var enemigosMuertos = 0
var seguirZombie = null
var estadoOleada: float
var maxOleada: int
var numeroOleada
var rng = RandomNumberGenerator.new()
var cantMates = 0
# Called when the node enters the scene tree for the first time.


func _ready():

	
	estadoOleada = 0
	maxOleada = 10
	numeroOleada = 0
	$Player/Interfaces/ProgressBar.aumentarMaximo(maxOleada) 
	$Player/Interfaces/ProgressBar.update(0)
	$Player/Interfaces/Oleada.text = "Oleada: "+str(numeroOleada)
	
	$Player.connect("Muerte",muerte)
	$Player.connect("subirNivel",aumentarNivel)
	$MenuMejoras.visible = false  # Oculta el menú al iniciar el juego.
	$menu_final.visible = false  # Oculta el menú al iniciar el juego.
	$Menu_pausa.visible = false
	$MenuMejoras.connect("aumentarDaño",aumentarDaño)
	$MenuMejoras.connect("aumentarVelocidad",aumentarVelocidad)
	$MenuMejoras.connect("aumentarVida",aumentarVida)
	$MenuMejoras.connect("mate", mate)
	
	$Menu_pausa.connect("reiniciar",reiniciar)
	$Menu_pausa.connect("reanudar",reanudar)
	


	$Enemigo.connect("muerto",aumentarOleada)
	
	$menu_final.connect("reiniciar", reiniciar)
	
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Player/Interfaces/contEnemigos.text = "enemigos: " +str(enemigosMuertos)
	$Player/Interfaces/Monedas.text = "Monedas: " + str(Guardado.game_data.monedas)
	$Player/Label.text = str($Player.experiencia)
	if Input.is_action_just_pressed("Pausa"):
		pausa()


func crear_zombie():
	$Player/Path2D/PathFollow2D.set_progress_ratio(rng.randf_range(0.0,1.0))
	var enemigo = Zombie.instantiate()
	add_child(enemigo)
	enemigo.connect("muerto",aumentarOleada)
	enemigo.position = $Player/Path2D/PathFollow2D.position
	enemigo.visibility_layer = 2
	
func _on_zombie_timer_timeout():
	crear_zombie()


func pausa():
	$Menu_pausa.visible = true  
	$Menu_pausa.pausar()
	
func reanudar():
	$Menu_pausa.visible = false 
	$Menu_pausa.pausar()


func muerte():
	$Timers/ZombieTimer.stop()
	if maxOleada > Guardado.game_data["oleadaMaxima"]:
		Guardado.game_data["oleadaMaxima"] = maxOleada
	$menu_final.visible = true
	Guardado.game_data["enemigosMuertos"] += enemigosMuertos
	Guardado.game_data["monedasTotales"] 
	#$menu_final/TextureRect.position = $Player.position
	$menu_final.muerto(numeroOleada)
	$menu_final.pausar()

func victira():
	if maxOleada > Guardado.game_data["oleadaMaxima"]:
		Guardado.game_data["oleadaMaxima"] = maxOleada
	$Timers/ZombieTimer.stop()
	$menu_final.visible = true
	#$menu_final/TextureRect.position = $Player.position
	Guardado.game_data["enemigosMuertos"] += enemigosMuertos
	$menu_final.ganar(numeroOleada)
	$menu_final.pausar()
	
func reiniciar():
	$menu_final.pausar()
	
func aumentarNivel():
	#Funcion que despliega el menu de mejoras
	
	#$MenuMejoras/TextureRect.position = $Player.position
	$MenuMejoras.visible = true  
	
	$MenuMejoras.pausar()
	
func aumentarDaño():
	$Player.aumentar_daño(100)
	$MenuMejoras.visible = false  
	#$MenuMejoras/TextureRect.hide()
	#$MenuMejoras/TextureRect.position = $Afuera.position
	$MenuMejoras.pausar()

func aumentarVelocidad():
	$Player.aumentar_velocidad(100)
	$MenuMejoras.visible = false  
	#$MenuMejoras/TextureRect.position = $Afuera.position
	$MenuMejoras.pausar()

func aumentarVida():
	$Player.aumentar_vida(100)
	$MenuMejoras.visible = false 
	#$MenuMejoras/TextureRect.position = $Afuera.position
	$MenuMejoras.pausar()

func mate():
	cantMates += 0.75
	var timerMate = $Timers/MateTimer 
	timerMate.wait_time = 3/ cantMates
	timerMate.start()
	$MenuMejoras.visible = false
	#$MenuMejoras/TextureRect.position = $Afuera.position
	$MenuMejoras.pausar()





func _on_mate_timer_timeout():
	var mate = Mate.instantiate()
	add_child(mate)
	mate.position = $Player.position
	seguirZombie = get_closest_object(get_tree().get_nodes_in_group("Enemigos"))
	mate.visibility_layer = 2
	mate.show_behind_parent = true
	mate.velocity = mate.global_position.direction_to(seguirZombie.global_position) * mate.SPEED



func aumentarOleada():
	enemigosMuertos += 1
	
	estadoOleada = 1 + estadoOleada
	$Player/Interfaces/ProgressBar.update((estadoOleada/maxOleada)*10)
	print((estadoOleada/maxOleada)*100)
	$Timers/ZombieTimer.wait_time = $Timers/ZombieTimer.wait_time/1.1
	if estadoOleada == maxOleada:
		
		$Timers/ZombieTimer.stop()
		$Timers/DOSTimer.start()
		for n in range(20):
			crear_zombie()
			
		estadoOleada = 0
		maxOleada = maxOleada +5
		$Player/Interfaces/ProgressBar.update((estadoOleada/maxOleada)*10)
		$Player/Interfaces/ProgressBar.aumentarMaximo(maxOleada)
		numeroOleada += 1
		$Player/Interfaces/Oleada.text = "Oleada: "+str(numeroOleada) 
		
		$Timers/ZombieTimer.wait_time = 1


func _on_dos_timer_timeout():
	if numeroOleada == 3:
			victira()
	else:
		Globales.VidaZombie += 200
		Globales.DañoZombie += 100
		$Timers/ZombieTimer.start()
	

func get_closest_object(objects):
	var closest_distance = INF
	var closest_object = null
	var current_position = $Player.global_position
	
	for obj in objects:
		var distance = current_position.distance_to(obj.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_object = obj
	return closest_object




