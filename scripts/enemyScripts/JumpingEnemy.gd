extends KinematicBody2D

func _ready():
	set_process(true)
	set_process_input(true)
	
func _on_Area2D_body_enter( body ):
	var groups = body.get_groups()	
	if (groups.has("player")):
		print("You died.")
		get_tree().quit()