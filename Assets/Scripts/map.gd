extends Node2D
signal no_enemies
@onready var enemy = $Enemy
@onready var tunnel = $Tunnel
var i =0
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	

func _process(delta):
	
	if find_child("Enemy") == null and i == 0:
		tunnel.queue_free()
		i+=1
		
