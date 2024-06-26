extends CharacterBody2D

#gen var


#signals
signal player_no_health

#children
@onready var health_bar = $ProgressBar
@onready var roll_timer = $Timer
@onready var player_hitbox = %player_hitbox
@onready var collider = $Collider
@onready var roll_cooldown = $"Roll-cooldown"


#character-specific variables
var STATE = null
const SPEED = 6500
var health = 5
const ROLL_SPEED = 10000
var can_roll = true
var roll_dir

func _process(_delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	if direction == Vector2.ZERO and roll_timer.is_stopped() == true:
		STATE = "idle" 
		player_hitbox.get_child(0).set_deferred("disabled", false)
	elif roll_timer.is_stopped() == true :
		STATE ="walk"
		player_hitbox.get_child(0).set_deferred("disabled", false)
		
	if Input.is_action_just_pressed("roll") and can_roll == true:
		can_roll = false
		STATE = "roll"
		roll_dir = direction
		roll_timer.start()
		roll_cooldown.start()
		
	if roll_cooldown.is_stopped() == true:
		can_roll = true
		
	if health <= 0 :
		player_no_health.emit()
		
	health_bar.value = health
	
		
func _ready():
	health_bar.max_value = health
	health_bar.value = health
	

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	match STATE:
		"idle":
			idle()
		"walk":
			velocity = SPEED*delta*direction
			move_and_slide()
			#print(STATE)
		"roll":
			roll(delta,roll_dir)
			player_hitbox.get_child(0).set_deferred("disabled", true)
			#print(STATE)
			
	
	var overlapping_bodies = %player_hitbox.get_overlapping_areas()
	if overlapping_bodies.size() > 0:
		health-= 1.5*delta*overlapping_bodies.size()
	
	
func roll(delta, direction):
	velocity = ROLL_SPEED*direction*delta
	move_and_slide()

func idle():
	pass



func _on_player_no_health():
	get_tree().paused = true

























