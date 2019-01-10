#RJ Compton
#MOVEMENT CODE
#OCTOBER 1, 2017

#UPDATED by RJ OCTOBER 7, 2017 ---- JUMPING INITIAL
#UPDATED by RJ October 9, 2017 ---- JUMPING FINAL
#UPDATED by RJ October 13, 2017 --- COLLISION

extends KinematicBody2D

var bulletDirections = {"Right": Vector2(4,0), "Left": Vector2(-4,0),
 "Up": Vector2(0,4), "Down": Vector2(0,-4), "UpLeft": Vector2(-2,-2),
 "UpRight": Vector2(2, -2), "DownLeft": Vector2(-2,2), "DownRight": Vector2(2,2)}

#DIRECTIONS
var input_direction = 0
var direction = 1
var aim = 2


#SPEEDS
var speed_x = 0
var speed_y = 0
var velocity = Vector2()

#CONSTANTS
const MAX_SPEED = 300
const DECELERATION = 250
const ACCELERATION = 150
const GRAVITY = 1400
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

	if Input.is_key_pressed(KEY_ESCAPE):
        if (get_tree().is_paused()):
            get_tree().set_pause(false)
        else:
            get_tree().set_pause(true)
            var pos = get_node("../Player").get_pos()
            get_node("../pause_popup").set_pos(Vector2(pos.x - 80, pos.y - 120))
            get_node("../pause_popup").show()

	if input_direction:
		direction = input_direction
	
	if Input.is_action_pressed("ui_up"):
		sprite.setAim(1)
		aim = 1
		
	elif Input.is_action_pressed("ui_down"):
		sprite.setAim(3)
		aim = 3
	else:
		sprite.setAim(2)
		aim = 2
	
	
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
		
	#SHOOTING
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var position = get_node("../Player").get_pos()
		var bullet_scene = preload("res://Bullets.tscn")
		var bullet = bullet_scene.instance()
		print("Aim: " + str(aim))
		print("Direction: " + str(direction))
		if (aim == 1 && direction == -1): #UpLeft
			bullet.velocity = bulletDirections.UpLeft
			bullet.set_pos(Vector2(position.x + 58, position.y + 57))
		elif (aim == 2 && direction == -1): #Left
			bullet.velocity = bulletDirections.Left
			bullet.set_pos(Vector2(position.x + 55, position.y + 65))
		elif (aim == 3 && direction == -1): #DownLeft
			bullet.velocity = bulletDirections.DownLeft
			bullet.set_pos(Vector2(position.x + 58, position.y + 77))
		elif (aim == 1 && direction == 1): #UpRight
			bullet.velocity = bulletDirections.UpRight
			bullet.set_pos(Vector2(position.x + 88, position.y + 57))
		elif (aim == 2 && direction == 1): #Right
			bullet.velocity = bulletDirections.Right
			bullet.set_pos(Vector2(position.x + 92, position.y + 65))
		else: #DownRight
			bullet.velocity = bulletDirections.DownRight
			bullet.set_pos(Vector2(position.x + 88, position.y + 78))
		get_tree().get_root().add_child(bullet)
	
	sprite.update(delta)	