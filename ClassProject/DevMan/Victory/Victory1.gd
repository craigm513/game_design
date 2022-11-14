extends Node2D

func _input(event):
    if event.is_action_pressed("ui_cancel"):
        get_tree().change_scene("res://Credits/GodotCredits.tscn")
    if event.is_action_pressed("ui_accept"):
        get_tree().change_scene("res://Credits/GodotCredits.tscn")
        
