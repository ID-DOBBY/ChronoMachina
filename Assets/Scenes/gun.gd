extends Node2D

@onready var crosshair = get_node("/root/Map/crosshair")
const BULLET = preload("res://Assets/Scenes/bullet.tscn")
@onready var rotation_point = $Rotation_Point


func _process(_delta):
	look_at(crosshair.global_position)
	rotation_point.look_at(crosshair.global_position)
	
	if Input.is_action_just_pressed("shoot"):
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = $Bullet_Spawn.global_position
		new_bullet.global_rotation = $Bullet_Spawn.global_rotation
		get_parent().get_parent().add_child(new_bullet)
