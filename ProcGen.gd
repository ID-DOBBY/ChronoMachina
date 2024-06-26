extends Node2D

enum roomType{Normal, Shop, Upgrade}
@onready var map = $TileMap

var num_Of_Rooms = randi_range(10,15)
var rooms = []
var room = {
	"position" = null,
	"type" = roomType.Normal,
	"size" = Vector2i( randi_range(8,15),randi_range(8,15))
}
var Shop_Placed = false
var Upgrade_count = randi_range(1,3)
var start = Vector2i(0,0)

const STARTER_ROOM = preload("res://Assets/Scenes/starter_room.tscn")
var map_size = Vector2i(randi_range(45,80),randi_range(45,80))


func _ready():
	var max_x = room["size"].x-1
	var max_y = room["size"].y-1
	for x in room["size"].x:
		for y in room["size"].y:
			if x == 0 and not y == 0 and not y == max_y:
				map.set_cell(0,Vector2i(x,y),0, Vector2i(13,5))
			elif x== max_x and not y== max_y and not y ==0:
				map.set_cell(0,Vector2i(x,y),0, Vector2i(11,5))
			elif y == 0 and not x == 0 and not x == max_x:
				map.set_cell(0,Vector2i(x,y),0, Vector2i(12,6))
			elif y == max_y and not x == max_x and not x ==0:
				map.set_cell(0,Vector2i(x,y),0, Vector2i(12,4))
			elif x== max_x and y == max_y :
				map.set_cell(0,Vector2i(x,y),0, Vector2i(15,5))
			elif x== 0 and y ==0:
				map.set_cell(0,Vector2i(x,y),0, Vector2i(14,4))
			elif x ==0 and y == max_y:
				map.set_cell(0,Vector2i(x,y),0, Vector2i(14,5))
			elif x== max_x and y ==0:
				map.set_cell(0,Vector2i(x,y),0, Vector2i(15,4))
			else:
				map.set_cell(0,Vector2i(x,y),0, Vector2i(0,0))

 
