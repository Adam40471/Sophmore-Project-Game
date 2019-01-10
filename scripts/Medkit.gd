extends Area2D

func _ready():
	pass

func _on_Medkit1_body_enter(body):
	var groups = body.get_groups()
	print("is colliding with medkit")
	
	if (groups.has("player") && body.get_node("Health Canvas").get_max_Health() < 100):
		body.get_node("Health Canvas").modify_health(50)
		#Print for testing purposes
		print("Extra Life Works")
		#Should vanish the item when its touched by player
		queue_free()

func _process(delta):