extends Marker2D


func _physics_process(_delta):
	var mouse_position = get_global_mouse_position()
	position = mouse_position
	

