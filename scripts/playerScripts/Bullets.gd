extends Area2D

var hit = false
var direction = 0
var velocity = Vector2(0,0)

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	self.set_pos(self.get_pos() + velocity)
#	if (bodies.size() > 0):
#		print("hi")

func _on_Bullets_area_enter(area):
	print(area.get_name())
	if (area.get_parent().has_method("decrease_Health")):
		area.get_parent().decrease_Health(50)
		self.queue_free()
	#print("hi")
	#commented out by Adam so it isnt breaking everything
	#area.queue_free()
	if (area.get_name() != "aggroArea"):
		self.queue_free()
		
func _hit_something():
	if (hit):
		return
	hit = true
	set_process(false)
	self.queue_free()

#func _shoot(aim, direction):
	
	

func _on_Bullets_body_enter( body ):
	#print("hello")
	self.queue_free()
	
	
	