extends Button

func _ready():
	pass


func _on_Resume_pressed():
	get_node("../../pause_popup").hide()
	get_tree().set_pause(false)
	pass 
