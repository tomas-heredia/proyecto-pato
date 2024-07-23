extends Node2D
@export var Zombie : PackedScene
@export var menuNivel : PackedScene
var estadoOleada = 1
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.connect("pararZombies",pararZombies)
	$Player.connect("subirNivel",aumentarNivel)
	$MenuMejoras.connect("aumentarDaño",aumentarDaño)
	$MenuMejoras.connect("aumentarVelocidad",aumentarVelocidad)
	$MenuMejoras.connect("aumentarVida",aumentarVida)
	$Enemigo.connect("muerto",aumentarOleada)
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Player/Label.text = str($Player.experiencia)

func crear_zimbie():
	$Player/Path2D/PathFollow2D.set_progress_ratio(rng.randf_range(0.0,1.0))
	var enemigo = Zombie.instantiate()
	add_child(enemigo)
	enemigo.position = $Player/Path2D/PathFollow2D.position
	
func _on_zombie_timer_timeout():
	crear_zimbie()

func pararZombies():
	$Timers/ZombieTimer.stop()

func aumentarDaño():
	$Player.aumentar_daño(100)
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
func aumentarNivel():
	
	$MenuMejoras/TextureRect.position = $Player.position
	$MenuMejoras.pausar()
	
func aumentarOleada():
	estadoOleada += 1
	$Timers/ZombieTimer.wait_time = $Timers/ZombieTimer.wait_time/estadoOleada
	if estadoOleada == 10:
		$Timers/ZombieTimer.stop()
		$Timers/DOSTimer.start()
		for n in range(50):
			crear_zimbie()
		estadoOleada = 1
	


func _on_dos_timer_timeout():
	$Timers/ZombieTimer.start()
	





















