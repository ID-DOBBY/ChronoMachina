extends CharacterBody2D
const SPEED = 150
var health = 5
@onready var timer = $Timer
signal player_no_health 
@onready var health_bar = $ProgressBar


func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = SPEED*direction
	
	move_and_slide()	
	var overlapping_bodies = %player_hitbox.get_overlapping_areas()
	if overlapping_bodies.size() > 0:
		health-= 1.5*delta*overlapping_bodies.size()
	
	if health <= 0:
		player_no_health.emit()
		
	health_bar.value = health




func _on_player_no_health():
	get_tree().reload_current_scene()
