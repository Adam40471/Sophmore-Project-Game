extends Area2D

func _ready():
	pass

func _on_Medkit1_body_enter(body):
	var groups = body.get_groups()
	print("is colliding with medkit")
	
	if (groups.has("player") && get_node("Player/Health Canvas").get_health() < 100):
		get_node("Player/Health Canvas").add_health(25)
		print("medkit works")
		queue_free()

func _process(delta):