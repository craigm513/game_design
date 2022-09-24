extends Control

func _on_CreditsButton_pressed():
    get_tree().change_scene("res://Credits.tscn")

func _on_StartButton_pressed():
    get_tree().change_scene("res://Space.tscn")
