extends Node2D
@onready var crosshair = get_node("/root/Map/crosshair")
var distance =0.0
func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	var speed = 160
	var range = 200
	position += speed*direction*delta
	
	
	distance += speed*delta
	if distance > range:
		queue_free()
	
	

func _on_bullet_area_entered(area):
	
	if area.get_parent().has_method("hurt") and not area.get_parent().has_method("_on_bullet_area_entered"):
		queue_free()
		area.get_parent().hurt()
		

	
