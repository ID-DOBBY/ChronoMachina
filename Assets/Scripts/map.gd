extends Node2D
signal no_enemies

@onready var camera = $TileMap/Camera2D
@onready var tunnel = $Tunnel
var i =0
var current_room = 1
const ENEMY = preload("res://Assets/Scenes/enemy.tscn")
@onready var spawn_pos = $Path2D/spawn_pos
@onready var timer = $Timer



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	

func _process(delta):
	
	var ammo_label = camera.get_child(0).get_child(0)
	var text = "AMMO: " + str(%Player/Gun.ammo)
	ammo_label.text = (text)
	match current_room:
		1:
			camera.global_position = global_position
			if $Enemies.get_child_count() == 0 and find_child("Tunnel"):
				tunnel.queue_free()
				
		null:
			camera.global_position = %Player.global_position
			camera.position_smoothing_enabled = true
		2:
			if timer.is_stopped() == true and i <5:
				timer.start(0.2)
				spawn_pos.progress_ratio = randf()
				var new_enemy = ENEMY.instantiate()
				new_enemy.global_position = spawn_pos.global_position
				find_child("Enemies").add_child(new_enemy)
				i+=1
			camera.global_position = %Player.global_position
			camera.position_smoothing_enabled = true
	
	
	
		
		


func _on_room_2_area_entered(area):
	current_room = 2
	
	


func _on_room_1_area_entered(area):
	current_room = 1
