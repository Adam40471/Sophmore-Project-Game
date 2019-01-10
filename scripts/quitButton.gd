extends Button

func _ready():
	pass


func _on_Quit_pressed():
	get_node("/root/global").setScene("res://MainMenu.tscn")
	for node in get_tree().get_root().get_children():
		print(node.get_filename())
#		if (node.get_name() == "Hello"):
#			print("MATCH")
	get_tree().set_pause(false)
	pass
