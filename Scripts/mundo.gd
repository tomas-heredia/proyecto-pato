extends Node2D
@export var Zombie : PackedScene
@export var menuNivel : PackedScene
var estadoOleada: float
var maxOleada: int
var numeroOleada
var rng = RandomNumberGenerator.new()
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
	
	$MenuMejoras.connect("aumentarDaño",aumentarDaño)
	$MenuMejoras.connect("aumentarVelocidad",aumentarVelocidad)
	$MenuMejoras.connect("aumentarVida",aumentarVida)
	
	$Enemigo.connect("muerto",aumentarOleada)
	
	$menu_final.connect("reiniciar", reiniciar)
	
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	$Player/Label.text = str($Player.experiencia)

func crear_zombie():
	$Player/Path2D/PathFollow2D.set_progress_ratio(rng.randf_range(0.0,1.0))
	var enemigo = Zombie.instantiate()
	add_child(enemigo)
	enemigo.connect("muerto",aumentarOleada)
	enemigo.position = $Player/Path2D/PathFollow2D.position
	enemigo.visibility_layer = 2
	
func _on_zombie_timer_timeout():
	crear_zombie()

func muerte():
	$Timers/ZombieTimer.stop()
	$menu_final/TextureRect.position = $Player.position
	$menu_final.muerto(numeroOleada)
	$menu_final.pausar()

func victira():
	$Timers/ZombieTimer.stop()
	$menu_final/TextureRect.position = $Player.position
	$menu_final.ganar(numeroOleada)
	$menu_final.pausar()
	
func reiniciar():
	$menu_final.pausar()
	
func aumentarNivel():
	
	$MenuMejoras/TextureRect.position = $Player.position
	
	$MenuMejoras.pausar()
	
func aumentarDaño():
	$Player.aumentar_daño(100)
	$MenuMejoras/TextureRect.hide()
	$MenuMejoras/TextureRect.position = $Afuera.position
	$MenuMejoras.pausar()

func aumentarVelocidad():
	$Player.aumentar_velocidad(100)
	$MenuMejoras/TextureRect.position = $Afuera.position
	$MenuMejoras.pausar()

func aumentarVida():
	$Player.aumentar_vida(100)
	$MenuMejoras/TextureRect.position = $Afuera.position
	$MenuMejoras.pausar()
func aumentarOleada():
	estadoOleada = 1 + estadoOleada
	$Player/Interfaces/ProgressBar.update((estadoOleada/maxOleada)*10)
	print((estadoOleada/maxOleada)*100)
	#$Timers/ZombieTimer.wait_time = $Timers/ZombieTimer.wait_time/1.2
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
		if numeroOleada == 1:
			victira()
		#$Timers/ZombieTimer.wait_time = 1


func _on_dos_timer_timeout():
	$Timers/ZombieTimer.start()
	





















