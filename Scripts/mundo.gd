extends Node2D
@export var Zombie : PackedScene
@export var menuNivel : PackedScene
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.connect("pararZombies",pararZombies)
	$Player.connect("subirNivel",aumentarNivel)
	$MenuMejoras.connect("aumentarDaño",aumentarDaño)
	$MenuMejoras.connect("aumentarVelocidad",aumentarVelocidad)
	$MenuMejoras.connect("aumentarVida",aumentarVida)
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Player/Label.text = str($Player.experiencia)


func _on_zombie_timer_timeout():
	$Player/Path2D/PathFollow2D.set_progress_ratio(rng.randf_range(0.0,1.0))
	var enemigo = Zombie.instantiate()
	add_child(enemigo)
	enemigo.position = $Player/Path2D/PathFollow2D.position

func pararZombies():
	$ZombieTimer.stop()

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
	
