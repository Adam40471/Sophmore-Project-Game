#RJ Compton
#MOVEMENT CODE
#OCTOBER 1, 2017

#UPDATED by RJ OCTOBER 7, 2017 ---- JUMPING INITIAL
#UPDATED by RJ October 9, 2017 ---- JUMPING FINAL
#UPDATED by RJ October 13, 2017 --- COLLISION

extends KinematicBody2D

const bulletDirections = {2: [Vector2(4,0),Vector2(19,65)],
 						0: [Vector2(0,4),Vector2(0,0)],
 						4: [Vector2(0,-4),Vector2(0,0)], 
 						1: [Vector2(2, -2),Vector2(15,57)],
				 	 	3: [Vector2(2,2),Vector2(15,78)]}

#AUDIO
var audioPlayer
var runAudioInt = null

#DIRECTIONS
var input_direction = 0
var direction = 1
var aim = 2

#TIMERS
var shootTime = 0
var runSoundTime = 0

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
	audioPlayer = get_parent().get_node("SamplePlayer")
	sprite.default("stand", aim, direction, false)

#SPECIAL INPUT (JUMP)	
func _input(event):
	if jumpCounter < maxJumps and event.is_action_pressed("jump"):
		speed_y = -JUMP_FORCE
		jumpCounter += 1
		audioPlayer.play("Jump")
	pass
	
func inputProccess(delta):
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
		input_direction = 1
		sprite.move(input_direction)
	else:
		input_direction = 0
		sprite.stopMoving()
			

func movementProcess(delta):
	if input_direction != direction: 
		if input_direction == 0:
			speed_x *= .9
		else:
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
			if(final_movement.x != 0):
				if runSoundTime == 0:
					runAudioInt = audioPlayer.play("Run")
					runSoundTime += delta
				else:
					runSoundTime += delta
					if runSoundTime >= 10.62:
						runSoundTime = 0
			else:
				if(runAudioInt != null): 
					audioPlayer.stop(runAudioInt)
					runAudioInt = null
				runSoundTime = 0
	else:
		if(runAudioInt != null): 
			audioPlayer.stop(runAudioInt)
			runAudioInt = null
		runSoundTime = 0
			

func shootingProcess(delta):
	if(shootTime > 0): 
		shootTime -= delta
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if(shootTime <= 0):
			shootTime = .25
			var position = get_node("../Player").get_pos()
			var bullet_scene = preload("res://scenes/playerScenes/Bullets.tscn")
			var bullet = bullet_scene.instance()
			
			bullet.velocity = bulletDirections[aim][0]
			bullet.velocity.x *= direction
			position += Vector2(0, -72)
			position.x += bulletDirections[aim][1].x * direction
			position.y += bulletDirections[aim][1].y
			bullet.set_pos(position)
			get_tree().get_root().add_child(bullet)
			audioPlayer.play("Laser")

#func _sound():
#	var music = get_node("SamplePlayer")
#	#music.play()

#RUNS EVERY FRAME	
func _process(delta):

	#INPUT GATHERING
	inputProccess(delta)
	#MOVEMENT CALCULATIONS
	movementProcess(delta)
	#SHOOTING
	shootingProcess(delta)
	
	sprite.update(delta)	