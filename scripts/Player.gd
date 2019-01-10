#RJ Compton
#MOVEMENT CODE
#OCTOBER 1, 2017

#UPDATED by RJ OCTOBER 7, 2017 ---- JUMPING INITIAL
#UPDATED by RJ October 9, 2017 ---- JUMPING FINAL
#UPDATED by RJ October 13, 2017 --- COLLISION

extends KinematicBody2D

#DIRECTIONS
var input_direction = 0
var direction = 1
var aim = 2


#SPEEDS
var speed_x = 0
var speed_y = 0
var velocity = Vector2()

#CONSTANTS
const MAX_SPEED = 150
const DECELERATION = 250
const ACCELERATION = 150
const GRAVITY = 1000
const JUMP_FORCE = 300
const fallSpeed = 250
var jumpCounter = 0
var maxJumps = 2


onready var sprite = get_node("Player Sprite")

#ALLOWS PROGRAM TO RUN
func _ready():
	set_process(true)
	set_process_input(true)
	sprite.default("stand", aim, direction, false)

#SPECIAL INPUT (JUMP)	
func _input(event):
	if jumpCounter < maxJumps and event.is_action_pressed("jump"):
		speed_y = -JUMP_FORCE
		jumpCounter += 1
	pass
	
#RUNS EVERY FRAME	
func _process(delta):
	
#KEYBOARD INPUTS

	if input_direction:
		direction = input_direction
	
	if Input.is_action_pressed("ui_up"):
		sprite.setAim(1)
		
	elif Input.is_action_pressed("ui_down"):
		sprite.setAim(3)
	else:
		sprite.setAim(2)
	
	
	if Input.is_action_pressed("ui_left"):
		input_direction = -1
		sprite.move(input_direction)
	elif Input.is_action_pressed("ui_right"):
		sprite.move(input_direction)
		input_direction = 1
	else:
		input_direction = 0
		sprite.stopMoving()
			
#MOVEMENT CALCULATIONS

	if input_direction == - direction:
		speed_x /= 3
	if input_direction:
		speed_x += ACCELERATION * delta
	else:
		speed_x -= DECELERATION * delta
		
	speed_x = clamp(speed_x, 0, MAX_SPEED)
	speed_y += GRAVITY * delta
	if speed_y > fallSpeed:
		speed_y = fallSpeed
	
	velocity.x = speed_x * delta * direction
	velocity.y = speed_y * delta
	
	var movement_remainder = move(velocity)
	
	move(velocity)
	
	#Collision
	if is_colliding():		
	#	print("AM I ON SURFACE??")
		var vector_normal = get_collision_normal()
		var final_movement = vector_normal.slide(movement_remainder)
		speed_y = vector_normal.slide(Vector2(0, speed_y)).y	
		
		move(final_movement)
		
		if vector_normal == Vector2(0, -1):
			jumpCounter = 0
		
	sprite.update(delta)	