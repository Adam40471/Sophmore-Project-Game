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
	if event.is_action_pressed("ui_accept"):
		health -= 10

#Controls how health regenerates
func _fixed_process(delta):
	get_node("Control/ProgressBar").set_value(health)
	health += delta * 2