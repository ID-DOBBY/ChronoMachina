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
var map_size = Vector2i(300,300)
var x_offset = randi_range(2,6)
var first_room = true

#tunnel vars
var tunnel_RNG
var tunnel_max = 1
var tunnel_chance
var tunnel_placed = 0
const TUNNEL = preload("res://Assets/Scenes/tunnel.tscn")
var current_pos
func _ready():
	Room_Gen()
	Door_gen()
	Corridor_gen()
	
	Room_Gen()
	Door_gen()
	

func Room_Gen():
	var max_x = room["size"].x-1
	var max_y = room["size"].y-1
	tunnel_RNG = randi_range(2, 8)
	tunnel_chance = 2
	print(start)
	for x in room["size"].x:
		print(start)
		for y in room["size"].y:
			
			if x == 0 and not y == 0 and not y == max_y :
				map.set_cell(0,start-Vector2i(x,y),0, Vector2i(11,5))
			elif x== max_x and not y== max_y and not y ==0:
				map.set_cell(0,start-Vector2i(x,y),0, Vector2i(13,5))
			elif y == 0 and not x == 0 and not x == max_x:
				map.set_cell(0,start-Vector2i(x,y),0, Vector2i(12,4))
			elif y == max_y and not x == max_x and not x ==0:
				map.set_cell(0,start-Vector2i(x,y),0, Vector2i(12,6))
			elif x== max_x and y == max_y :
				map.set_cell(0,start-Vector2i(x,y),0, Vector2i(14,4))
			elif x== 0 and y ==0:
				map.set_cell(0,start-Vector2i(x,y),0, Vector2i(15,5))
			elif x ==0 and y == max_y:
				map.set_cell(0,start-Vector2i(x,y),0, Vector2i(15,4))
			elif x== max_x and y ==0:
				map.set_cell(0,start-Vector2i(x,y),0, Vector2i(14,5))
			else:
				map.set_cell(0,start-Vector2i(x,y),0, Vector2i(0,0))
	if not first_room:
		start.x -= x_offset+1
		map.set_cell(0,start,0, Vector2i(0,0))
		start.x -= 1
		map.set_cell(0,start,0, Vector2i(13,4))
		start.x += 2
		map.set_cell(0,start,0, Vector2i(11,4))
		start.x += x_offset
	first_room = false

func Door_gen():
	var max_x = room["size"].x-1
	var max_y = room["size"].y-1
	tunnel_placed = 0
	for x in room["size"].x:
		tunnel_chance += 1
		for y in room["size"].y:
			y = -y
			if y== -max_y and not x == 0 and not x == max_x and tunnel_chance > tunnel_RNG and tunnel_placed < 1:
				map.set_cell(0,start-Vector2i(x,-y),0, Vector2i(0,0))
				map.set_cell(0,start-Vector2i(x-1,-y),0, Vector2i(11,6))
				map.set_cell(0,start-Vector2i(x+1,-y),0, Vector2i(13,6))
				var tunnel = TUNNEL.instantiate()
				tunnel_placed += 1
				tunnel.set_global_position(start - Vector2i((-start.x+x)*map.tile_set.tile_size.x-map.tile_set.tile_size.x/2, -(start.y+y)*map.tile_set.tile_size.y-map.tile_set.tile_size.y/2) )
				print("tunnel pos" +str(tunnel.global_position) + str(x,y))
				tunnel.name = "Tunnel" +str(tunnel_placed)
				add_child(tunnel)
				current_pos = -Vector2i(x,-y)
	start = current_pos
	


func Corridor_gen():
	var corridor_length = randi_range(2,5)
	var corridor_size = Vector2i(3,corridor_length)
	var max_x = corridor_size.x-1
	var max_y = corridor_size.y-1
	start.x = start.x +1
	start.y = start.y -1
	print(start)
	for x in corridor_size.x:
		for y in corridor_size.y:
			if x == 0 and not y == 0 and not y == max_y :
				map.set_cell(0,start-Vector2i(x,y),0, Vector2i(11,5))
			elif x== max_x and not y== max_y and not y ==0:
				map.set_cell(0,start-Vector2i(x,y),0, Vector2i(13,5))
			elif y == max_y and not x == max_x and not x ==0:
				map.set_cell(0,start-Vector2i(x,y),0, Vector2i(12,6))
			elif x== max_x and y == max_y :
				map.set_cell(0,start-Vector2i(x,y),0, Vector2i(14,4))
			elif x== 0 and y ==0:
				map.set_cell(0,start-Vector2i(x,y),0, Vector2i(11,5))
			elif x ==0 and y == max_y:
				map.set_cell(0,start-Vector2i(x,y),0, Vector2i(15,4))
			elif x== max_x and y ==0:
				map.set_cell(0,start-Vector2i(x,y),0, Vector2i(13,5))
			else:
				map.set_cell(0,start-Vector2i(x,y),0, Vector2i(0,0))
			current_pos = Vector2i(x,y)
	start.y -= corridor_size.y -1
	start.x += x_offset


