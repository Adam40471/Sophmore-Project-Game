extends KinematicBody2D


#SPEEDS
var speed_x = 0
var speed_y = 0
var velocity = Vector2()

#CONSTANTS
const MAX_SPEED = 100
const DECELERATION = 50
const ACCELERATION = 50
const GRAVITY = 2250
const JUMP_FORCE = 300

export (int) var damage = 25
export (int) var currentHealth = 100
export (int) var maxHealth = 100

onready var damage_delay = get_node("damage_delay_timer")

var damageEnabled = false
	

#DIRECTIONS
var input_direction = 0
var direction = 0

#ALLOWS PROGRAM TO RUN
func _ready():
	set_process(true)
	set_process_input(true)

#SPECIAL INPUT (JUMP)	
func _input(event):
	if event.is_action_pressed("jump"):
		speed_y = -JUMP_FORCE
	pass
	
#RUNS EVERY FRAME	
func _process(delta):
	
#KEYBOARD INPUTS

	if input_direction:
		direction = input_direction
	
	if Input.is_action_pressed("ui_left"):
		input_direction = -1
	elif Input.is_action_pressed("ui_right"):
		input_direction = 1
	else:
		input_direction = 0
			
#MOVEMENT CALCULATIONS

	if input_direction == - direction:
		speed_x /= 3
	if input_direction:
		speed_x += ACCELERATION * delta
	else:
		speed_x -= DECELERATION * delta
		
	speed_x = clamp(speed_x, 0, MAX_SPEED)
	speed_y += GRAVITY * delta
	
	velocity.x = speed_x * delta * direction
	velocity.y = speed_y * delta
	
	var movement_remainder = move(velocity)
	
	move(velocity)
	
func _on_Area2D_body_enter( body ):
	var groups = body.get_groups()
	var healthDamage = -50
	
	if (groups.has("player")):
		body.get_node("Health Canvas").modify_health(-50)
		#speed_y = -JUMP_FORCE - 200
		#pass
		#queue_free()
		
	pass # replace with function body
	
func on_damage_delay_timeout():
	damageEnabled = false
	
