extends CharacterBody2D

@onready var player = get_node("/root/Main/Map/Player")
const SPEED = 40
var health = 2
signal no_health

func hurt():
	health -=1
	if health == 0:
		no_health.emit()

func _physics_process(_delta):
	
	var direction = global_position.direction_to(player.global_position)
	
	velocity = SPEED*direction
	
	move_and_slide()
	

	

func _on_no_health():
	queue_free()





func _on_hitbox_body_entered(body):
	pass


func _on_hitbox_area_entered(area):
	pass
