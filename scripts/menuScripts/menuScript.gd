extends Node


func _ready():
	pass

func _on_Play_pressed():
	get_tree().change_scene("res://Environment.tscn")
	#get_node("res://scripts/menuScripts/global.gd").setScene("res://Environment.tscn")


func _on_Options_pressed():
	get_tree().change_scene("res://scenes/menuScenes/OptionsMenu.tscn")
	#get_node("res://scripts/menuScripts/global.gd").setScene("res://scenes/menuScenes/OptionsMenu.tscn")


func _on_Credits_pressed():
	pass

func _on_Exit_pressed():
	get_tree().quit()


func _on_Back_pressed():
	get_tree().change_scene("res://scenes/menuScenes/MainMenu.tscn")
	#get_node("res://scripts/menuScripts/global.gd").setScene("res://scenes/menuScenes/MainMenu.tscn")


func _on_SoundEfx_pressed():
	get_tree().change_scene("res://scenes/menuScenes/SoundEfxMenu.tscn")
	#get_node("res://scripts/menuScripts/global.gd").setScene("res://scenes/menuScenes/SoundEfxMenu.tscn")


func _on_Controls_pressed():
	get_tree().change_scene("res://scenes/menuScenes/Controls.tscn")
	#get_node("res://scripts/menuScripts/global.gd").setScene("res://scenes/menuScenes/Controls.tscn")


func _on_BackToMainMenu_pressed():
	get_tree().change_scene("res://scenes/menuScenes/MainMenu.tscn")
	#get_node("res://scripts/menuScripts/global.gd").setScene("res://scenes/menuScenes/MainMenu.tscn")


func _on_HSlider_changed():
	pass


func _on_HSlider_value_changed( value ):
	AudioServer.set_stream_global_volume_scale(value)


func _on_Button_2_pressed():
	get_tree().change_scene("res://scenes/menuScenes/MainMenu.tscn")
	#get_node("res://scripts/menuScripts/global.gd").setScene("res://scenes/menuScenes/MainMenu.tscn")
