extends Node2D

const title_color := Color.blueviolet

#func _ready():

func _input(event):
	print( "input event is:", event)
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit( 0 )
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://MainMenu/MainMenu.tscn")
		
