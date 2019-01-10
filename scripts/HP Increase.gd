#Adam Hamed
#Max HP Increase code
#OCTOBER 17th, 2017

#Updated to work correctly on October 19th

extends Area2D

func _ready():
	pass

func _on_HealthUP_body_enter(body):
	var groups = body.get_groups()
	
	#If the player is touching the HealhUP object and they dont already have 899 max hp
	if (groups.has("player") && body.get_node("Health Canvas").get_max_Health() < 899):
		#calls the function to add 100 to max health
		body.get_node("Health Canvas").HealthTank()
		#Vanishes the item when its touched by player
		queue_free()

func _process(delta):