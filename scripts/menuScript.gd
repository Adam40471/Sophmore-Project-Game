extends VBoxContainer


func _ready():
	pass

func _on_Play_pressed():
	get_node("../../global").setScene("res://Environment.tscn")


func _on_Options_pressed():
	get_node("../../global").setScene("res://OptionsMenu.tscn")


func _on_Credits_pressed():
	pass

func _on_Exit_pressed():
	get_tree().quit()


func _on_Back_pressed():
	get_node("../../global").setScene("res://MainMenu.tscn")


func _on_SoundEfx_pressed():
	get_node("../../global").setScene("res://SoundEfxMenu.tscn")


func _on_Controls_pressed():
	get_node("../../global").setScene("res://Controls.tscn")


func _on_BackToMainMenu_pressed():
	get_node("../../global").setScene("res://MainMenu.tscn")


func _on_HSlider_changed():
	pass


func _on_HSlider_value_changed( value ):
	AudioServer.set_stream_global_volume_scale(value)


func _on_Button_2_pressed():
	get_node("../../global").setScene("res://MainMenu.tscn")
