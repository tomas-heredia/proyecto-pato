extends Node2D
@export var Zombie : PackedScene
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_zombie_timer_timeout():
	$Player/Path2D/PathFollow2D.set_progress_ratio(rng.randf_range(0.0,1.0))
	var enemigo = Zombie.instantiate()
	add_child(enemigo)
	enemigo.position = $Player/Path2D/PathFollow2D.position
