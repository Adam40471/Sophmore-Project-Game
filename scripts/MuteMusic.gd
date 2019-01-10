extends Button

func _ready():
	pass


func _on_MuteMusic_pressed():
	if (AudioServer.get_stream_global_volume_scale() == 0):
		AudioServer.set_stream_global_volume_scale(1)
	else:
		AudioServer.set_stream_global_volume_scale(0)
	pass 
