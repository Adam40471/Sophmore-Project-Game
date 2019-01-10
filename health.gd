#Adam Hamed
#Health Bar code
#OCTOBER 10, 2017

extends CanvasLayer

var ExtraHealthList = ["Control/Extra Health1", "Control/Extra Health2", "Control/Extra Health3", "Control/Extra Health4", "Control/Extra Health5", "Control/Extra Health6", "Control/Extra Health7", "Control/Extra Health8"]
var ExtraHealthAccess = StringArray(ExtraHealthList)

var isAlive = true
var healthLevel = 9
var health = 100

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	
	#They begin hidden since you dont start with extra health
	#Currently commented out for testing purposes
	#get_node("Control/Extra Health1").set_frame(255)
	#get_node("Control/Extra Health2").set_frame(255)
	#get_node("Control/Extra Health3").set_frame(255)
	#get_node("Control/Extra Health4").set_frame(255)
	#get_node("Control/Extra Health5").set_frame(255)
	#get_node("Control/Extra Health6").set_frame(255)
	#get_node("Control/Extra Health7").set_frame(255)
	#get_node("Control/Extra Health8").set_frame(255)
	pass

#Decrements health for testing purposes
func _input(event):
	if event.is_action_pressed("ui_accept"):
		health = health - 50

func 

func _fixed_process(delta):
	get_node("Control/ProgressBar").set_value(health)
	
	#This drops your health level down by 1 if you reach 0/100 health in your current level	
	if(health == 0):
		healthLevel = healthLevel - 1
		#Refills health bar after dropping down a Health Level, provided youre still alive
		if(healthLevel >= 1):
			health = 100
		else:
			isAlive = false
		#Takes away a Extra Health Crystal icon when health bar is emptied
		if(healthLevel >= 1):
			for i in range(1, 10):
				get_node(ExtraHealthAccess[healthLevel-1]).set_frame(1)