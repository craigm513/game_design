extends Node

func MasterSlideChange(value:float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),value)

func _on_BackButton_pressed():
	get_tree().change_scene("res://MainMenu/MainMenu.tscn")

func _input(event):
	if event.is_action_pressed( "ui_cancel" ) :
		get_tree().change_scene("res://MainMenu/MainMenu.tscn")
