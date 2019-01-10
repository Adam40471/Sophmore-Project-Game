extends KinematicBody2D

#ENEMY MASTER SCRIPT -----------------------------------

#BASIC STATISTIC VARIABLES
export (int) var maxHealth = 200
export (int) var currentHealth = 200
export (int) var damage = 25

#BASIC MOVEMENT VARIABLES
export (int) var directionH = 1
export (int) var directionV = 1
export (int) var speedH = 0
export (int) var speedV = 0
export (int) var acceleration = 0

#WEAPON SPECIFIC VARIABLES
#Stops an enemy from moving for 2 seconds.
export (bool) var vulnFreeze = true
#Slows an enemy for 5 seconds.
export (bool) var vulnElectric = true

#ENEMY TYPE VARIABLE
#Set this number inside of the game to the enemy type
#you are looking for:

#1 is Basic left-right moving enemy
#2 is Basic up-down moving enemy
#3 is Fast left-right moving enemy
#4 is Fast up-down moving enemy
#5 is Slow moving, tracking enemy
#6 is Boss one, bullet-Hell, stationary

# [Speed V, Speed H, Acceleration, Damage Amount, Actions Function Reference]	
var enemyLibrary = {1: [0, 150, 10, null], 2: [150, 0, 0, null], 3: [0, 450, 5, null], 4: [450, 0, 5, null], 5: [200, 200, 2.5, funcref(self, "action1")], 6: [0, 0, 0, funcref(self, "action2")]}

export (int) var enemyType = 5

#This allows the script to run when the game begins.
func _ready():
	set_process(true)
	set_process_input(true)
	
	speedH = enemyLibrary[enemyType][0]
	speedV = enemyLibrary[enemyType][1]
	acceleration = enemyLibrary[enemyType][2]


#RUNS EVERY FRAME AND SETS ENEMY TYPE
func _process(delta):
	#Enemy type should be set before this point
	
	#if normal default movement will call action
	if (enemyLibrary[enemyType][3] == null):
		action(delta)
	else: #if special movement call enemy specific function to override
		enemyLibrary[enemyType][3].call_func(delta)
	
#PUT DEFAULT ACTION/MOVEMENT CODE HERE
func action(delta):
	#print("default")
	pass
#PUT OVERRIDING ACTION/MOVEMENT CODE HERE - CURRENTLY USED IN ENEMY 5
func action1(delta):
	#print("act1")
	pass
	
func action2(delta):
	print("act2")
	
#Placed here by ADAM; Decrements enemy Health
func decrease_Health(amount):
	currentHealth = currentHealth - amount
	#If enemy has no health left they die
	if (currentHealth <= 0):
		queue_free()
	#Limits enemys health so it doesn't go above its maxHealth
	if (currentHealth > maxHealth):
		currentHealth = maxHealth

#Keeps the enemy within a specific Area 2D named cage.
func _on_Area2D_body_exit( body ):
	var groups = body.get_groups()
	
	if (groups.has("cage")):
		directionH = -directionH
		directionV = -directionV
	
	#func _on_Area2D_body_enter(body):
    #print(str('Body entered: ', body.get_name()))
	
	#func _on_Area2D_body_enter(body):
    #if body.is_in_group("player"):
     #print(str('Player has entered')
	
	
func _on_Area2D_body_enter( body ):
	var groups = body.get_groups()
	#Print for testing purposes
	print(str('Body entered: ', body.get_name()))
	if (groups.has("player")):
		body.get_node("Health Canvas").modify_health(-damage)
		
	elif (groups.has("bullet")):
		self.decrease_Health(50)