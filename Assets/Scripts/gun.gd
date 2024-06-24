extends Node2D

@onready var timer = $Timer
@onready var crosshair = get_node("/root/Main/Map/crosshair")
const BULLET = preload("res://Assets/Scenes/bullet.tscn")
@onready var rotation_point = $Rotation_Point
var ammo = 6

func _process(_delta):
	look_at(crosshair.global_position)
	rotation_point.look_at(crosshair.global_position)
	
	if Input.is_action_just_pressed("shoot") and ammo > 0 and timer.is_stopped() == true:
		ammo -= 1
		timer.start(0.3)
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = $Bullet_Spawn.global_position
		new_bullet.global_rotation = $Bullet_Spawn.global_rotation
		get_parent().get_parent().add_child(new_bullet)
		
	if Input.is_action_just_pressed("reload"):
		await get_tree().create_timer(1.2).timeout
		ammo = 6
		
