#Adam Hamed
#Health Bar code
#OCTOBER 10, 2017

extends CanvasLayer

var isAlive = true
#Change this healthLevel value to test HP crystal mechanics functionality
var healthLevel = 1
var health = 100

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	pass

#Controls how health decrements
func _input(event):
	#for testing
	
	if event.is_action_pressed("ui_accept"):
		health = health - 10

#Controls how health regenerates
func _fixed_process(delta):
	get_node("Control/ProgressBar").set_value(health)
	
	#If there is no health left in the final level of health, you die
	#currently need to make something where isAlive being false kills the player
	if(healthLevel == 0):
		isAlive = false
	#This drops your health level down by 1 if you reach 0/100 health in your current lvl
	#Need to make the crystal icons work with this, but the functionality is there.
	elif(health == 0):
		healthLevel = healthLevel - 1
		#This is important. It refills the main health bar after dropping down a health level
		#However, it does not refill it when you should be dead.
		#Still need to make a HP crystal go away when you drop down a level
		#Also need to make a function in the health pickup class to
		#add increase your health level in the firstplace
		if(healthLevel >= 1):
			health = 100
			
		
		
	#health regeneration over time (for testing)
	#health += delta * 2
