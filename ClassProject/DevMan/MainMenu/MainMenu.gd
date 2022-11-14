extends Control

func _on_StartButton_pressed():
  get_tree().change_scene("res://LevelSelect/LevelSelect1.tscn")

func _on_CreditsButton_pressed():
	get_tree().change_scene("res://Credits/GodotCredits.tscn")

func _input(event):
	if event.is_action_pressed( "ui_cancel" ) :
	  get_tree().quit( 0 )
