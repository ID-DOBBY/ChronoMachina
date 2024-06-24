extends CharacterBody2D

#gen var


#signals
signal player_no_health

#children
@onready var health_bar = $ProgressBar

#character-specific variables
var STATE = null
const SPEED = 6500
var health = 5
const ROLL_SPEED = 10500

func _ready():
	health_bar.max_value = health
	health_bar.value = health
	

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	
	match STATE:
		"idle":
			print(STATE)
		"walk":
			velocity = SPEED*delta*direction
			move_and_slide()
			print(STATE)
		"roll":
			move(delta,direction)
			print(STATE)
			
	if direction == Vector2.ZERO:
		STATE = "idle" 
	else:
		STATE ="walk"
		
	if Input.is_action_just_pressed("roll"):
		STATE = "roll"
	
	
	var overlapping_bodies = %player_hitbox.get_overlapping_areas()
	if overlapping_bodies.size() > 0:
		health-= 1.5*delta*overlapping_bodies.size()
	
	if health <= 0 :
		player_no_health.emit()
		
	health_bar.value = health
	
func move(delta,direction):
	velocity = delta*ROLL_SPEED*direction*5
	move_and_slide()



func _on_player_no_health():
	get_tree().paused = true
























