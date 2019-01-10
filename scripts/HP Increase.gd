extends Area2D

func _ready():
	pass

func _on_HealthUP_body_enter(body):
	var groups = body.get_groups()
	
	if (groups.has("player") && body.get_node("Health Canvas").get_max_Health() < 899):
		body.get_node("Health Canvas").HealthTank()
		#Should vanish the item when its touched by player
		queue_free()

func _process(delta):