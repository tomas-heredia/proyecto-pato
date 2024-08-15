extends Area2D
signal Impacto

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func impacto():
	$CollisionShape2D.disabled = true
	print("llega")
	emit_signal("Impacto")

