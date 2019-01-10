extends Area2D

var hit = false
var direction = 0
var velocity = Vector2(0,0)
var timer = 0
var sinAng = 0

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	timer += delta
	sinAng = velocity.angle()
	
	self.set_pos(self.get_pos() + velocity)
	#self.set_pos(self.get_pos() + velocity + Vector2((1/(timer+.2))*cos(timer*20),0).rotated(sinAng ))
	

func damageable(area):
	if (area.get_name() != "aggroArea" && area.get_parent().has_method("decrease_Health")):
		return true
	else:
		return false

func _on_Bullets_area_enter(area):
	if damageable(area):
		area.get_parent().decrease_Health(20)
		self.queue_free()
	
func _on_Bullets_body_enter( body ):
	if (body.has_method("damage")):
		body.damage(10)
	self.queue_free()

func _on_Rocket_area_enter( area ):
	if damageable(area):
		area.get_parent().decrease_Health(40)
		self.queue_free()

func _on_Rocket_body_enter( body ):
	if (body.get_name() == "Main"):
		self.queue_free()

func _on_Shock_area_enter( area ):
	if damageable(area):
		area.get_parent().decrease_Health(40)
		self.queue_free()

func _on_Shock_body_enter( body ):
	if (body.get_name() == "Main"):
		self.queue_free()

func _on_Freeze_area_enter( area ):
	if damageable(area):
		area.get_parent().decrease_Health(40)
		self.queue_free()

func _on_Freeze_body_enter( body ):
	if (body.get_name() == "Main"):
		self.queue_free()
