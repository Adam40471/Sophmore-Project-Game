#Adam Hamed
#Health Bar code
#OCTOBER 10, 2017

extends CanvasLayer

var ExtraHealthList = ["Control/Extra Health1", "Control/Extra Health2", "Control/Extra Health3", "Control/Extra Health4", "Control/Extra Health5", "Control/Extra Health6", "Control/Extra Health7", "Control/Extra Health8"]
var ExtraHealthAccess = StringArray(ExtraHealthList)

var isAlive = true
var healthLevel = 1
var maxHealth = 99
var health = 50

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	
	get_node("Control/ProgressBar").set_value(health % 100)
	
	#They begin hidden since you dont start with extra health
	get_node("Control/Extra Health1").set_frame(255)
	get_node("Control/Extra Health2").set_frame(255)
	get_node("Control/Extra Health3").set_frame(255)
	get_node("Control/Extra Health4").set_frame(255)
	get_node("Control/Extra Health5").set_frame(255)
	get_node("Control/Extra Health6").set_frame(255)
	get_node("Control/Extra Health7").set_frame(255)
	get_node("Control/Extra Health8").set_frame(255)
	pass

func _input(event):
	if event.is_action_pressed("Damager"):
		modify_health(-5)
	if event.is_action_pressed("HPIncrease"):
		modify_health(5)
	if event.is_action_pressed("HealthTank"):
		HealthTank()

func HealthTank():
	if (maxHealth < 899):
		maxHealth = maxHealth + 100
		modify_health(100)
	print(maxHealth)
		
func get_health():
	return health

func modify_health(amount):
	health = health + amount
	if (health > maxHealth):
		health = maxHealth
	get_node("Control/ProgressBar").set_value(health  % 100)

	if (health <= 0):
		isAlive = false

		#Takes away a Extra Health Crystal icon when health bar is emptied
		#But leaves an empty container there to signify you have unlocked Extra Health
	if(maxHealth / 100 >= 1):
		for i in range(1, maxHealth / 100 + 1):
			if(health / 100 >= i):
				get_node(ExtraHealthAccess[i-1]).set_frame(0)
			else:
				get_node(ExtraHealthAccess[i-1]).set_frame(1)
	

func _fixed_process(delta):
	