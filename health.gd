#Adam Hamed
#Initial Health Bar code
#OCTOBER 9, 2017

extends CanvasLayer

var health = 100

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	pass

#Controls how health decrements
func _input(event):
	#for testing
	if event.is_action_pressed("ui_accept"):
		health -= 10

#Controls how health regenerates
func _fixed_process(delta):
	get_node("Control/ProgressBar").set_value(health)
	
	# Here is where we will do things when the health bar reaches 0
	#if(health == 0):
		#health = 100
		
	#health regeneration over time (for testing)
	#health += delta * 2