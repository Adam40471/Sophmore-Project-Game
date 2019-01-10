extends Button

func _ready():
	pass


func _on_MuteSFX_pressed():
	if (AudioServer.get_fx_global_volume_scale() == 0):
		AudioServer.set_fx_global_volume_scale(1)
	else:
		AudioServer.set_fx_global_volume_scale(0)
	pass 