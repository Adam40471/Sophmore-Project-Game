extends KinematicBody2D

var initial_direction = 0
var direction = 0
var speed = 0
var MAX_SPEED = 600
var ACCELERATE = 100
var DECELERATE = 250
var velocity = 0;


var velocityY = 0;

 
#INITIALIZE PROGRAM
 
func _ready():
    set_process(true)  
    set_fixed_process(true)
    pass
   
#STEP FUNCTION 
func _process(delta):
   
    #MOVEMENT INPUTS       
    if Input.is_action_pressed("ui_up"):
        velocityY =-100*delta
    if Input.is_action_pressed("ui_down"):
        velocityY = 100*delta

    if Input.is_action_pressed("ui_left"):
        initial_direction = -1     
    elif Input.is_action_pressed("ui_right"):
        initial_direction = 1      
    else:
        initial_direction = 0
       
    if initial_direction:
        direction = initial_direction
       
    #MOVEMENT CALCULATIONS
  
    if initial_direction == -direction:
        speed /=3  
       
    if initial_direction:
        speed += ACCELERATE * delta    
    else:
        speed -= DECELERATE * delta
   
    #ensures speed does not freak out
    speed = clamp(speed, 0, MAX_SPEED)
    
    #velocity calculation      
    velocity = speed * delta * initial_direction
    move(Vector2(velocity, velocityY))
    pass
   
    #END CODE
	
	
	
#RJ Compton
#INITIAL MOVEMENT CODE
#OCTOBER 1, 2017

	
